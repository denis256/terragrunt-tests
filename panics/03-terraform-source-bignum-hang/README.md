# 03 - terraform.source huge-exponent number hang

Class: HANG (resource exhaustion, no panic, never returns in practical time)
Severity: denial of service
Gated: no, works on a default install

## What it does

Same root cause as case 02, reached through a different codepath. Here the
huge-exponent number is assigned to the string-typed `terraform.source` field.
Decoding the config converts the number to a string via gohcl, which triggers
the same go-cty decimal formatting. Because this happens during config decode,
any command that loads the config hangs, not just render.

## Files

- `terragrunt.hcl` - `terraform { source = 9E9999999 }`
- `main.tf` - a trivial module (not reached, the hang is at decode time)

## Reproduce

```bash
timeout 20 terragrunt render --working-dir .   # does not finish, killed by timeout
```

`terragrunt run -- plan`, `terragrunt validate`, and `terragrunt hcl validate`
hang the same way, since all of them decode the config first.

Observed: killed by the timeout (exit code 124). A moderate exponent shows the
super-linear cost.

## Root cause

`gohcl.DecodeBody` decoding the `terraform` block coerces the number to the
`*string` source field, which calls go-cty `convert.Convert(number, string)` and
then `big.Float.Text('f', -1)`. Same conversion as case 02, different entry
point. The decode site for an ordinary `terragrunt.hcl` is
`pkg/config/hclparse/file.go` via `decodeAsTerragruntConfigFile`.

## Fix direction

Same as case 02: bound numeric-literal magnitude before string coercion, applied
at the shared decode boundary so it covers `terraform.source`, `engine.source`,
inputs, and stack files alike.
