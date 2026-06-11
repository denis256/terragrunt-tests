# autoinclude: object-literal computed KEY leaks a generate-time reference

When an object's value references `dependency.*` (so the whole object takes the structural partial-eval path),
an interpolated object **key** such as `"${local.prefix}_key"` is emitted **verbatim** into the generated unit
instead of being resolved, leaking `local.*` (or `values.*`/`unit.*`/`stack.*`) into a context where it does
not exist. The generated unit then fails at runtime referencing the nonexistent reference.

## Reproduce

```
cd live
terragrunt stack generate --experiment stack-dependencies
cat .terragrunt-stack/app/terragrunt.autoinclude.hcl
```

Before fix:
```hcl
mixed_obj = { "${local.prefix}_key" = dependency.vpc.outputs.id }   # KEY leaks local.prefix
```

After fix:
```hcl
mixed_obj = { "pre_key" = dependency.vpc.outputs.id }               # KEY resolved
```

The sibling `pure_obj` resolves its key in both cases; only the mixed object (which references a dependency in
its value, taking the structural path) leaked the key.

## Root cause / fix

`internal/hclparse/partial_eval.go` `partialEvalObject` only partial-evaluated `item.ValueExpr`, never the key.
Fix: partial-evaluate computed keys (`item.KeyExpr.Variables()` non-empty; bare-identifier keys stay verbatim)
plus an `ObjectConsKeyExpr` case. Found by the autoinclude all-constructs coverage test.
