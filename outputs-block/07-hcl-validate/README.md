# 07 - hcl validate on a tree where the contracts hold

With the experiment on, `terragrunt hcl validate` checks two things in
addition to its usual work:

1. every output declared in an `outputs` block exists in the OpenTofu/Terraform
   module of that unit;
2. every `dependency.<name>.outputs.<key>` reference names a declared output
   when the dependency declares outputs.

Here both hold, so the command exits 0 and prints no diagnostics.

## Run

```bash
export TG_EXPERIMENT=outputs-block
terragrunt hcl validate
echo "exit=$?"
```

## Expected

```
exit=0
```
