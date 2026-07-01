# 06 - sensitive() marked value panic

Class: PANIC (uncaught Go panic, process aborts)
Severity: crash
Gated: no

## What it does

`sensitive()` is a built-in OpenTofu and Terraform function that Terragrunt
exposes in its HCL evaluation context. It returns the same value carrying a cty
"mark". Terragrunt never strips that mark before handing values to go-cty
operations that require an unmarked value (`gohcl` struct decode, `hclwrite`
serialization, `AsString`). As a result, wrapping almost any string attribute in
`sensitive()` crashes the whole process with:

```
panic: value is marked, so must be unmarked first
```

A plain unmarked value in the same place works fine, so the mark is the trigger.

## Sub-cases (one per distinct codepath)

| Dir | Attribute | Command | Crash site |
|-----|-----------|---------|------------|
| `a-terraform-source` | `terraform.source = sensitive(".")` | `render` | `pkg/config/hclparse/file.go:67` gohcl decode |
| `b-stack-unit-source` | `unit.source = sensitive("./app")` | `stack generate` | `pkg/config/hclparse/file.go:67` gohcl decode |
| `c-stack-values` | `unit.values.secret = sensitive("...")` | `stack generate` | `pkg/config/stack.go:931` hclwrite |
| `d-engine-meta` | `engine.meta.secret = sensitive("...")` | `render` | `pkg/config/config.go:484` render WriteTo |

Sub-cases `a` and `b` share the same crash line (the gohcl decode in
`File.Decode`) but reach it from two different config surfaces (an ordinary
`terragrunt.hcl` versus a `terragrunt.stack.hcl`). Sub-cases `c` and `d` are
distinct serialization codepaths.

## Reproduce

```bash
cd a-terraform-source && terragrunt render --working-dir .
cd ../b-stack-unit-source && terragrunt stack generate --working-dir .
cd ../c-stack-values && terragrunt stack generate --working-dir .
cd ../d-engine-meta && terragrunt render --working-dir .
```

Each aborts with `panic: value is marked, so must be unmarked first`.

## Root cause

go-cty asserts a value is unmarked before `AsString` and friends
(`cty/marks.go`). The marked value comes from `sensitive()`, which Terragrunt
adds to the eval context by merging the OpenTofu function scope
(`pkg/config/config_helpers.go`). The consuming sites do not unmark:

- `pkg/config/hclparse/file.go:67` calls `gohcl.DecodeBody` on a body whose
  attributes may carry marks.
- `pkg/config/stack.go:931` (and `:920` for a fully marked object) passes marked
  values into `hclwrite`.
- `pkg/config/config.go:484` serializes `engine.meta` with `hclwrite`.

## Fix direction

Deep-unmark decoded values, or reject marked values with a clean typed error,
before handing them to `gohcl` or `hclwrite`. The cleanest single point is to
unmark inside `(*File).Decode` so every decode surface is covered, plus an
unmark in the stack `writeValues` and `engine.meta` serialization paths.
