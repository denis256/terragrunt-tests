# 01 - basic: declare once, every dependent gets the mocks

`vpc` declares its two outputs and their mock values in an `outputs` block.
`app` reads them through a plain `dependency` block with no `mock_outputs`
of its own, and echoes them as `output` blocks in its `main.tf`, so every
plan and apply prints the values it received.

## Files

```
vpc/terragrunt.hcl   outputs block: vpc_id, subnet_ids, mocks allowed for validate and plan
vpc/main.tf          output "vpc_id" = "vpc-real", output "subnet_ids" = [...]
app/terragrunt.hcl   dependency "vpc", inputs from dependency.vpc.outputs.*
app/main.tf          variable + output for vpc_id and subnet_ids
```

`vpc/terragrunt.hcl`:

```hcl
outputs {
  mock_strategy {
    allowed_commands = ["validate", "plan"]
  }

  output "vpc_id" {
    mock_value = "vpc-mock"
  }

  output "subnet_ids" {
    mock_value = ["subnet-mock-1", "subnet-mock-2"]
  }
}
```

`app/terragrunt.hcl`:

```hcl
dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.subnet_ids
}
```

`app/main.tf`:

```hcl
variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

output "vpc_id" {
  value = var.vpc_id
}

output "subnet_ids" {
  value = var.subnet_ids
}
```

## Plan prints the mocks, apply prints the real values

Start from a fresh tree (no state files; see Cleanup in the top README).

```bash
export TG_EXPERIMENT=outputs-block
terragrunt run --all plan        # vpc not applied yet: app shows the mocks from vpc
terragrunt run --all apply       # vpc applies first, then app with the real values
terragrunt run --all output      # the real values, now in state
```

`run --all plan`:

```
[vpc] tofu: Changes to Outputs:
[vpc] tofu:   + subnet_ids = [
[vpc] tofu:       + "subnet-real-1",
[vpc] tofu:       + "subnet-real-2",
[vpc] tofu:     ]
[vpc] tofu:   + vpc_id     = "vpc-real"
[app] tofu: Changes to Outputs:
[app] tofu:   + subnet_ids = [
[app] tofu:       + "subnet-mock-1",
[app] tofu:       + "subnet-mock-2",
[app] tofu:     ]
[app] tofu:   + vpc_id     = "vpc-mock"
```

`run --all apply`, the `app` part:

```
[app] tofu: Outputs:
[app] tofu: subnet_ids = tolist([
[app] tofu:   "subnet-real-1",
[app] tofu:   "subnet-real-2",
[app] tofu: ])
[app] tofu: vpc_id = "vpc-real"
```

`run --all output`:

```
subnet_ids = [
  "subnet-real-1",
  "subnet-real-2",
]
vpc_id = "vpc-real"
subnet_ids = tolist([
  "subnet-real-1",
  "subnet-real-2",
])
vpc_id = "vpc-real"
```

After apply, tofu prints `No changes.` on plan and hides the outputs, because
it shows outputs in a plan only when they change. The state lives in
`.terragrunt-cache` inside each unit; remove those directories to see the
mocks again:

```bash
rm -rf vpc/.terragrunt-cache app/.terragrunt-cache
```

`terragrunt apply` in `app` alone before `vpc` is applied is refused on
purpose: `allowed_commands` lets only validate and plan run on mocks. Apply
`vpc` first, or use `run --all apply` as above.

## See the mock values without running tofu

`render` resolves the `dependency` block the same way `plan` does:

```bash
cd app
terragrunt render                              # inputs with the mocks filled in
terragrunt render --format json | jq .inputs   # the same as JSON
cd ../vpc
terragrunt render --format json | jq .outputs  # the contract as vpc declares it
```

```hcl
dependency "vpc" {
  config_path = "../vpc"
}
inputs = {
  subnet_ids = ["subnet-mock-1", "subnet-mock-2"]
  vpc_id     = "vpc-mock"
}
```

`.dependency.vpc.mock_outputs` in that render stays `null`: the dependent
wrote no mocks, they come from the block in `vpc`.
