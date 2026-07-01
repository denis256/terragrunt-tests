# Autoinclude: dependency outputs cannot flow into a nested stack's `values`

Community support repro + proposed solution.

A top-level stack tries to feed a dependency's **output** down into a nested stack by
putting a `dependency` + `inputs` in an `autoinclude` on a `stack` block. This cannot work:

- Dependency outputs are **run-time** data (the dependency unit must actually run).
- A nested stack's `values` are resolved at **generate** time.
- A `terragrunt.stack.hcl` has no `inputs`; stacks pass data down via `values`.

The goal (centralize the output manipulation, keep leaf units scaffold-simple) is still
achievable: centralize the *wiring*, not the *data*.

## Variants

| Dir            | What it shows | `terragrunt stack generate --experiment stack-dependencies` |
|----------------|---------------|-------------------------------------------------------------|
| `live/`        | broken: dependency+inputs in a **stack**-block autoinclude | rejected with guidance (see below) |
| `inject/`      | top stack tries to inject a **unit-targeted** autoinclude into the nested stack | fails: injected `unit` is missing required `source`/`path` (does not merge onto the base unit) |
| `fixed/`       | dependency + manipulation on the **unit's** autoinclude (single level) | generates a valid unit `terragrunt.autoinclude.hcl` |
| `nested-fixed/`| the recommended **nested** pattern: composite unit carries the autoinclude; top passes the dependency path via `values` | generates the leaf unit's autoinclude end to end |

## Broken (`live/`)

```
ERROR ... dependency block is not allowed in a stack autoinclude; ... a stack autoinclude
may inject only unit and stack blocks; declare the dependency inside the target unit's own
autoinclude instead
```

(Older versions did not reject it — they emitted an inert `inputs` block into the nested
`terragrunt.autoinclude.stack.hcl` and then failed cryptically with
`This object does not have an attribute named "maas_url"` when the nested unit read
`values.maas_url`, which the top level never set.)

## Recommended solution (`nested-fixed/`)

Put the `dependency` and the consumption of its outputs on the **leaf unit's** `autoinclude`
(in the reusable composite), where outputs resolve at the unit's run time. Pass only the
dependency *path* from the top level via `values` (using the v1.0.7 `unit.<name>.path` /
`stack.<name>.path` exposure for cross-level paths).

Top level passes the path:

```hcl
stack "enlist" {
  source = "../catalog/enlist-stack"
  path   = "enlist"

  values = {
    install_path = "../../../../install" # or stack.<name>.path / unit.<name>.path
  }
}
```

Composite unit carries the wiring + manipulation:

```hcl
unit "enlist" {
  source = "${get_repo_root()}/.../catalog/units/enlist"
  path   = "unit_enlist"

  autoinclude {
    dependency "install" {
      config_path = values.install_path
      mock_outputs = { deploy = { url = "mock-url" } }
    }
    inputs = {
      maas_url = dependency.install.outputs.deploy.url
    }
  }
}
```

Generated leaf-unit `terragrunt.autoinclude.hcl` (verified):

```hcl
dependency "install" {
  config_path = "../../../../install"
  mock_outputs = { deploy = { url = "mock-url" } }
}

inputs = {
  maas_url = dependency.install.outputs.deploy.url
}
```

The leaf unit module stays trivial (`variable "maas_url"`), the wiring + manipulation live in
the composite, and only the dependency path crosses the stack boundary.

## Possible enhancement

`inject/` shows a gap: a `stack`-block autoinclude that injects `unit "X" { autoinclude {...} }`
fails because the generated `terragrunt.autoinclude.stack.hcl` is decoded standalone and the
injected unit requires `source`/`path`. If a stack autoinclude could *contribute* an
autoinclude to a same-named nested unit (merge by name, no `source`/`path` redeclared), a
deployment-level stack could own the dependency wiring directly. Not supported today.
