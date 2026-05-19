# Stack Dependencies Examples

Examples for [RFC #5663](https://github.com/gruntwork-io/terragrunt/issues/5663) - Stack Dependencies via Autoinclude.

Each example lives in its own directory and follows the same layout:

```
<example>/
  catalog/            # reusable units (and reusable stacks where applicable)
  live/
    terragrunt.stack.hcl
  README.md           # scenario, expected output, run steps
```

## Examples

| Directory                                  | Scenario                                                                                          |
|--------------------------------------------|---------------------------------------------------------------------------------------------------|
| [basic/](basic/)                           | Two sibling units, one depends on the other via `autoinclude`.                                    |
| [nested-stack/](nested-stack/)             | A unit depends on a unit inside a nested `stack` via `stack.<stack>.<unit>.path`.                  |
| [nested-same-name/](nested-same-name/)     | `stack "foo"` containing `unit "foo"`. Shows `stack.foo.path` vs `stack.foo.foo.path` (RFC sketch). |
| [mixed-stack-unit/](mixed-stack-unit/)     | A single `autoinclude` block declares deps on both `stack.foo.provider` and sibling `unit.baz`.    |
| [locals-in-stack/](locals-in-stack/)       | `locals` resolve at generation time everywhere, including inside `autoinclude`.                    |
| [values-in-stack/](values-in-stack/)       | `values` propagate from parent stack into a reusable child stack, including inside `autoinclude`.  |

## Common prerequisites

- Terragrunt built from the `prototype-stack-dependecnies` branch
- OpenTofu (>= 1.6.0) or Terraform (>= 0.12.0)

## Common flow

```bash
cd <example>/live
terragrunt stack generate --experiment stack-dependencies
terragrunt run --all --experiment stack-dependencies -- plan
terragrunt run --all --experiment stack-dependencies -- apply -auto-approve
terragrunt stack clean
```

See each example's `README.md` for the expected `terragrunt.autoinclude.hcl` output, dependency ordering, and validation commands.
