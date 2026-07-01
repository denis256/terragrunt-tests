# 04 - Stack unit source huge-exponent number hang

Class: HANG (resource exhaustion, no panic, never returns in practical time)
Severity: denial of service
Gated: no, ReadStackConfigFile decodes the stack file without any experiment

## What it does

Same root cause as cases 02 and 03, reached through the stack-file decoder.
The huge-exponent number is assigned to a unit's string-typed `source` field.
`ReadStackConfigFile` decodes the stack file unconditionally, so
`terragrunt stack generate` hangs while decoding, before any unit is generated.

This codepath is NOT behind the `stack-dependencies` experiment, unlike the
panic in case 01.

## Files

- `terragrunt.stack.hcl` - `unit "x" { source = 9E9999999, path = "x" }`
- `units/x/terragrunt.hcl` and `units/x/main.tf` - a trivial unit (not reached)

## Reproduce

```bash
timeout 20 terragrunt stack generate --working-dir .   # does not finish, killed by timeout
```

Observed: killed by the timeout (exit code 124). A moderate exponent shows the
super-linear cost.

## Root cause

`pkg/config/stack.go` `ReadStackConfigFile` calls `file.Decode` into the stack
unit struct, where the `source`/`path` string fields trigger go-cty
`convert.Convert(number, string)` and `big.Float.Text`. Same conversion as cases
02 and 03, different decode entry point.

## Fix direction

Same as cases 02 and 03: a magnitude bound at the shared decode boundary covers
this entry point too.
