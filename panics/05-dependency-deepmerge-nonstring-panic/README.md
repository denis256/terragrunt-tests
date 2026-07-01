# 05 - Dependency deep-merge non-string config_path panic

Class: PANIC (uncaught Go panic, process aborts)
Severity: crash
Gated: no
Reliability: intermittent, a goroutine race. Run a few times.

## What it does

When an `include` uses `merge_strategy = "deep"` and both the parent and the
child declare a `dependency` block with the SAME label, Terragrunt deep-merges
the two dependency blocks. The merge calls `config_path.AsString()` without
checking that the value is a string. If the child's `config_path` is a number,
bool, list, or object, `AsString()` panics with `not a string`.

A normal (non-include) dependency with a non-string `config_path` is rejected
cleanly by `IsValidConfigPath`. The deep-merge path runs before or independent
of that validation, so it slips through and crashes.

## Files

- `root.hcl` - parent config with `dependency "d"` (string config_path)
- `child/terragrunt.hcl` - child with a deep include and `dependency "d"`
  whose `config_path` is a bool
- `child/main.tf` - trivial module

## Reproduce

```bash
cd child
terragrunt hcl validate --working-dir .
```

This is intermittent because dependency parsing runs in a goroutine pool. Rerun
a few times; it panics on most runs.

Observed:

```
panic: not a string
github.com/zclconf/go-cty/cty.Value.AsString(...)
        pkg/config/dependency.go:92    (*Dependency).DeepMerge
        pkg/config/include.go:672      deepMergeDependencyBlocks
        pkg/config/include.go:244      handleIncludeForDependency
        pkg/config/dependency.go:278   decodeAndRetrieveOutputs
```

## Root cause

`pkg/config/dependency.go:92` in `(*Dependency).DeepMerge`:

```go
if sourceDepConfig.ConfigPath.AsString() != "" { // panics if ConfigPath is not a string
```

`ConfigPath` is a raw `cty.Value` field with no string-type enforcement. The
same unguarded pattern also exists at `pkg/config/include.go:585` in
`fetchDependencyPaths`.

## Fix direction

Guard the call with the existing `IsValidConfigPath` helper, or check
`ConfigPath.Type().Equals(cty.String)` and non-null before `AsString()`. Apply
the same guard at `include.go:585`.
