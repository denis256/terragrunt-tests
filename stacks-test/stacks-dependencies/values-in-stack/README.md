# Stack Dependencies - Values in Stack Example

Based on [RFC #5663](https://github.com/gruntwork-io/terragrunt/issues/5663) - Stack Dependencies via Autoinclude.

## What this demonstrates

`values` passed from a parent stack into a reusable child stack drive both:

- `source` and `path` expressions for `unit`/`stack` blocks inside the child
- `mock_outputs` and `inputs` inside an `autoinclude` block (unlike `locals`, which are blocked)

A single reusable child stack `catalog/stacks/cloud` is instantiated twice from the live stack, once with `cloud = "aws"` and once with `cloud = "gcp"`. The child stack picks a cloud-specific provider unit based on `values.cloud`.

## Directory structure

```
values-in-stack/
  catalog/
    stacks/
      cloud/
        terragrunt.stack.hcl   # reusable: picks provider via values.cloud
    units/
      aws-provider/
      gcp-provider/
      consumer/
  live/
    terragrunt.stack.hcl       # calls cloud stack twice with different values
```

## Stack files

`live/terragrunt.stack.hcl`:

```hcl
stack "aws" {
  source = "../catalog/stacks/cloud"
  path   = "aws"
  values = {
    cloud = "aws"
  }
}

stack "gcp" {
  source = "../catalog/stacks/cloud"
  path   = "gcp"
  values = {
    cloud = "gcp"
  }
}
```

`catalog/stacks/cloud/terragrunt.stack.hcl`:

```hcl
unit "provider" {
  source = "../../units/${values.cloud}-provider"
  path   = "provider"
}

unit "consumer" {
  source = "../../units/consumer"
  path   = "consumer"

  autoinclude {
    dependency "provider" {
      config_path = unit.provider.path
      mock_outputs_allowed_terraform_commands = ["validate", "plan"]
      mock_outputs = {
        val = "fake-${values.cloud}-val"   # values.* OK inside autoinclude
      }
    }

    inputs = {
      val   = dependency.provider.outputs.val
      cloud = values.cloud
    }
  }
}
```

## Why `values.*` is allowed inside autoinclude but `local.*` is not

`values` are resolved at stack generation time and baked into the generated `terragrunt.autoinclude.hcl` as literals, so the file remains self-contained. `locals` from the stack scope would not be visible at unit-evaluation time, so they are rejected at generation. See `locals-in-stack/` for the contrast.

## How to run

```bash
cd live
terragrunt stack generate --experiment stack-dependencies
terragrunt run --all --experiment stack-dependencies -- apply -auto-approve
```

Expected generated layout:

```
live/.terragrunt-stack/
  aws/
    provider/    # from aws-provider module
    consumer/
      terragrunt.autoinclude.hcl
  gcp/
    provider/    # from gcp-provider module
    consumer/
      terragrunt.autoinclude.hcl
```

The two `terragrunt.autoinclude.hcl` files differ only in their `mock_outputs.val` and `inputs.cloud` literals (`fake-aws-val` vs `fake-gcp-val`).

Validate:

```bash
cat .terragrunt-stack/aws/consumer/.terragrunt-cache/*/input.txt
# Expected: cloud=aws val=aws-provider-val

cat .terragrunt-stack/gcp/consumer/.terragrunt-cache/*/input.txt
# Expected: cloud=gcp val=gcp-provider-val
```

## Clean up

```bash
terragrunt stack clean
```

## RFC reference

Corresponds to the `values.*` expressions in the RFC #5663 sketch (source / path / config_path interpolation):
https://github.com/gruntwork-io/terragrunt/issues/5663
