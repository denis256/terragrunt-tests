# 12 - error: malformed outputs blocks

Three units, each wrong in one way.

```
deep-merge       merge_with_state = "deep"          not a mock merge strategy
type-attribute   output "vpc_id" { type = ... }     no type attribute in the pilot
two-blocks       two outputs blocks in one unit     only one is allowed
```

## Run

```bash
export TG_EXPERIMENT=outputs-block
for u in deep-merge type-attribute two-blocks; do (cd $u && terragrunt plan); done
```

## Expected

```
merge_with_state "deep" in the outputs block of .../deep-merge/terragrunt.hcl is
unknown. Valid values are: no_merge, shallow, deep_map_only.

.../type-attribute/terragrunt.hcl:8,5-9: Unsupported argument; An argument named
"type" is not expected here.

.../two-blocks/terragrunt.hcl:12,1-8: Duplicate outputs block; Only one outputs
block is allowed. Another was defined at .../two-blocks/terragrunt.hcl:5,1-8.
```
