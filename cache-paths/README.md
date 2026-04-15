# Cache Paths - Backward-Compatible Module References

Tests that `source = "../../modules/gcp-project"` relative paths in `.tf` files work correctly with terragrunt when running from project directories.

## Structure

```
cache-paths/
├── root.hcl              # shared root config (included by projects)
├── modules/
│   ├── gcp-project/      # outputs: project_id, project_number
│   ├── gcp-network/      # outputs: network_id, network_self_link
│   └── gcp-iam/          # outputs: iam_binding_id
└── projects/
    ├── project-alpha/     # uses gcp-project + gcp-network
    ├── project-beta/      # uses gcp-project + gcp-iam
    └── project-gamma/     # uses all 3 modules
```

## Run

Single project:

```bash
cd projects/project-alpha
terragrunt init
terragrunt plan
terragrunt apply
```

All projects:

```bash
cd projects
terragrunt run-all init
terragrunt run-all plan
terragrunt run-all apply
```

Destroy:

```bash
cd projects
terragrunt run-all destroy
```
