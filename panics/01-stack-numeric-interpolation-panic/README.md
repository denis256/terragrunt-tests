# 01 - Stack autoinclude numeric interpolation panic

Class: PANIC (uncaught Go panic, process aborts)
Severity: crash
Gated: yes, requires the `stack-dependencies` experiment

## What it does

`terragrunt stack generate` partial-evaluates the expressions inside an
`autoinclude` block so it can write a `terragrunt.autoinclude.hcl`. The partial
evaluator stringifies every literal part of a quoted template by calling
`cty.Value.AsString()`. A template part like `${1}` is a NUMBER literal, not a
string, so `AsString()` panics with `not a string`.

The crash only happens when a numeric (or bool, or float) interpolation is mixed
in the same string with a deferred `dependency.*` reference. The dependency
reference forces the whole template through the partial evaluator instead of the
pure fast path.

## Files

- `live/terragrunt.stack.hcl` - the stack file with the offending `inputs` value
- `catalog/units/vpc` - a unit that exposes `vpc_id`
- `catalog/units/app` - a unit that consumes the generated `name` input
- `variants/bool.terragrunt.stack.hcl` - same bug via `${true}`
- `variants/float.terragrunt.stack.hcl` - same bug via `${1.5}`

## Reproduce

```bash
cd live
terragrunt stack generate --experiment stack-dependencies --working-dir .
```

Observed:

```
panic: not a string
github.com/zclconf/go-cty/cty.Value.AsString(...)
        internal/hclparse/partial_eval.go:246
        internal/hclparse/partial_eval.go:67
        internal/hclparse/partial_eval.go:56
        internal/hclparse/partial_eval.go:116
        internal/hclparse/partial_eval.go:298
        internal/hclparse/partial_eval.go:73
```

To try the variants, copy one over `live/terragrunt.stack.hcl` and rerun:

```bash
cp variants/bool.terragrunt.stack.hcl live/terragrunt.stack.hcl
cd live && terragrunt stack generate --experiment stack-dependencies --working-dir .
```

Both `bool` and `float` panic at the identical line `partial_eval.go:246`.

## Root cause

`internal/hclparse/partial_eval.go:246` in `partialEvalTemplate`:

```go
if lit, ok := part.(*hclsyntax.LiteralValueExpr); ok {
    buf.Write(HCLStringContent(lit.Val.AsString())) // panics if lit.Val is not a string
    continue
}
```

The branch directly below (line 254) already does the safe thing with
`convert.Convert(val, cty.String)` plus an error and null guard. The literal
branch should mirror it.

## Fix direction

Convert instead of asserting:

```go
if lit, ok := part.(*hclsyntax.LiteralValueExpr); ok {
    strVal, err := convert.Convert(lit.Val, cty.String)
    if err == nil && !strVal.IsNull() {
        buf.Write(HCLStringContent(strVal.AsString()))
        continue
    }
    buf.Write(RangeBytes(args.SrcBytes, part.Range()))
    continue
}
```

`convert` and `cty` are already imported. This is the only unchecked
`AsString` of its kind in the package; the sibling sites in `autoinclude.go`
and `parse.go` are already type-checked.
