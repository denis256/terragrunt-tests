# autoinclude: panic on a non-string literal interpolation in a template

`terragrunt stack generate --experiment stack-dependencies` **panics** (`not a string`) when an autoinclude
template interpolates a non-string literal (e.g. `${0}`, `${true}`) and the expression takes the structural
partial-eval path (because it also references `dependency.*` or another value that can't resolve at generate).

## Reproduce

```
cd live
terragrunt stack generate --experiment stack-dependencies
```

Before fix:
```
panic: not a string [recovered, repanicked]
...
github.com/gruntwork-io/terragrunt/internal/hclparse.partialEvalTemplate(...)
```

After fix, the generated `.terragrunt-stack/app/terragrunt.autoinclude.hcl` contains:
```hcl
v = "0-${dependency.vpc.outputs.id}"   # ${0} resolves to 0; dependency.* stays verbatim
```

## Root cause / fix

`internal/hclparse/partial_eval.go` `partialEvalTemplate` treated every `LiteralValueExpr` template part as
static string text and called `.AsString()` on it; `${0}` is a `LiteralValueExpr` holding a *number*. Fix:
only take the static-text fast path when `lit.Val.Type() == cty.String`, otherwise let the part fall through
to the resolve-and-convert path. Found by fuzzing autoinclude block bodies.
