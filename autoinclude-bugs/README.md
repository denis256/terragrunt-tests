# autoinclude failing cases (stack-dependencies experiment)

Run each: `cd <case>/live && terragrunt stack generate --experiment stack-dependencies`

- **case1-object-key-leak** — an interpolated object KEY (`"${local.prefix}_key"`) leaks verbatim
  into the generated unit when a sibling value references `dependency.*` (mixed object takes the
  structural path; `partialEvalObject` never evaluates `item.KeyExpr`). Pure objects resolve the key.
- **case2-dead-branch-sideeffect** — `run_cmd` in the NON-selected branch of a pure conditional
  executes at generate time (HCL evaluates both branches of a conditional for type unification).
- **case4-nested-autoinclude-dropped** — a `unit` injected by a stack autoinclude that carries its
  own nested `autoinclude { dependency ... }` is left verbatim in the generated
  `terragrunt.autoinclude.stack.hcl`; the dependency is never resolved.

(`values = {...}` attribute writing through is intended now — not a bug.)
Already reported separately: ../6288 (unit.<n>.path in values fails when a sibling has autoinclude),
../6289 (stack-dir expansion ignores sibling terragrunt.values.hcl).
