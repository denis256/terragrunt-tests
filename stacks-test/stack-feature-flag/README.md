# Stack Feature Flags - Selective Unit Deployment

Demonstrates Terragrunt stacks with feature flags and filter flags to selectively deploy units of a 3-tier application.

## Architecture

```
frontend (app_url) --> backend (api_endpoint) --> db (db_endpoint)
```

Each unit has its own feature flag. Dependencies use `mock_outputs` so any unit can be deployed independently.

## Structure

```
units/
  db/          - database, outputs db_endpoint
  backend/     - API server, depends on db, outputs api_endpoint
  frontend/    - web app, depends on backend, outputs app_url
dev/           - dev environment stack definition
prod/          - prod environment stack definition
```

## Feature Flags

| Flag | Default | Controls |
|------|---------|----------|
| `deploy_db` | `true` | Database unit |
| `deploy_backend` | `true` | Backend API unit |
| `deploy_frontend` | `true` | Frontend web unit |

Docs: https://terragrunt.gruntwork.io/docs/features/runtime-control/

---

## Quick Start

### 1. Generate stack

```bash
cd dev
terragrunt stack generate
```

Output:
```
Generating unit frontend from ./terragrunt.stack.hcl
Generating unit db from ./terragrunt.stack.hcl
Generating unit backend from ./terragrunt.stack.hcl
```

This creates `.terragrunt-stack/` with db/, backend/, frontend/ subdirectories.

### 2. Plan all units

```bash
terragrunt run -all -- plan
```

Output:
```
Unit queue will be processed for plan in this order:
- Unit .terragrunt-stack/db
- Unit .terragrunt-stack/backend
- Unit .terragrunt-stack/frontend

[db]       + db_endpoint = "myapp-dev-db.db.local"
[backend]  + api_endpoint = "myapp-dev-backend.api.local"
[backend]  + db_endpoint  = "myapp-dev-db.db.local"
[frontend] + api_endpoint = "myapp-dev-backend.api.local"
[frontend] + app_url      = "https://myapp-dev-frontend.app.local"

Run Summary  3 units
   Succeeded    3
```

### 3. Apply all units

```bash
terragrunt run -all -- apply -auto-approve
```

Output:
```
Unit queue will be processed for apply in this order:
- Unit .terragrunt-stack/db
- Unit .terragrunt-stack/backend
- Unit .terragrunt-stack/frontend

[db]       Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
[db]       db_endpoint = "myapp-dev-db.db.local"

[backend]  Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
[backend]  api_endpoint = "myapp-dev-backend.api.local"
[backend]  db_endpoint = "myapp-dev-db.db.local"

[frontend] Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
[frontend] api_endpoint = "myapp-dev-backend.api.local"
[frontend] app_url = "https://myapp-dev-frontend.app.local"

Run Summary  3 units
   Succeeded    3
```

### 4. View all outputs

```bash
terragrunt stack output
```

Output:
```
backend = {
  api_endpoint = "myapp-dev-backend.api.local"
  db_endpoint  = "myapp-dev-db.db.local"
}
db = {
  db_endpoint = "myapp-dev-db.db.local"
}
frontend = {
  api_endpoint = "myapp-dev-backend.api.local"
  app_url      = "https://myapp-dev-frontend.app.local"
}
```

---

## Feature Flag Examples

Feature flags use `--feature` to exclude units via the `exclude` block in each unit's `terragrunt.hcl`.
Flags go BEFORE `--` (they are terragrunt flags, not terraform flags).

### Deploy only db

```bash
terragrunt run -all --feature deploy_backend=false --feature deploy_frontend=false -- plan
```

Output:
```
Unit queue will be processed for plan in this order:
- Unit .terragrunt-stack/db

[db] + db_endpoint = "myapp-dev-db.db.local"

Run Summary  3 units
   Succeeded    1
   Excluded     2
```

### Deploy only backend (uses mock db_endpoint)

```bash
terragrunt run -all --feature deploy_db=false --feature deploy_frontend=false -- plan
```

Output:
```
Unit queue will be processed for plan in this order:
- Unit .terragrunt-stack/backend

[backend] + api_endpoint = "myapp-dev-backend.api.local"
[backend] + db_endpoint  = "mock-db.local"

Run Summary  3 units
   Succeeded    1
   Excluded     2
```

Note: `db_endpoint = "mock-db.local"` because db is excluded and mock_outputs are used.

### Deploy only frontend (uses mock api_endpoint)

```bash
terragrunt run -all --feature deploy_db=false --feature deploy_backend=false -- plan
```

Output:
```
Unit queue will be processed for plan in this order:
- Unit .terragrunt-stack/frontend

[frontend] + api_endpoint = "mock-api.local"
[frontend] + app_url      = "https://myapp-dev-frontend.app.local"

Run Summary  3 units
   Succeeded    1
   Excluded     2
```

### Deploy db + backend only (skip frontend)

```bash
terragrunt run -all --feature deploy_frontend=false -- plan
```

Output:
```
Unit queue will be processed for plan in this order:
- Unit .terragrunt-stack/db
- Unit .terragrunt-stack/backend

Run Summary  3 units
   Succeeded    2
   Excluded     1
```

### Apply with feature flags

```bash
terragrunt run -all --feature deploy_backend=false --feature deploy_frontend=false -- apply -auto-approve
```

### Destroy with feature flags

```bash
terragrunt run -all -- destroy -auto-approve
```

---

## Filter Flag Examples

`--filter` selects units by name or path at the CLI level, no HCL changes needed.
Docs: https://terragrunt.gruntwork.io/docs/features/filter/

### Run only frontend

```bash
terragrunt run -all --filter 'frontend' -- plan
```

Output:
```
Unit queue will be processed for plan in this order:
- Unit .terragrunt-stack/frontend

Run Summary  1 units
   Succeeded    1
```

### Run only db

```bash
terragrunt run -all --filter 'db' -- plan
```

### Run only backend

```bash
terragrunt run -all --filter 'backend' -- plan
```

### Run multiple units (union with multiple --filter)

```bash
terragrunt run -all --filter 'db' --filter 'backend' -- plan
```

Output:
```
Unit queue will be processed for plan in this order:
- Unit .terragrunt-stack/db
- Unit .terragrunt-stack/backend

Run Summary  2 units
   Succeeded    2
```

### Run frontend and all its dependencies (graph traversal)

`frontend...` means "frontend plus everything it depends on" (backend and db).

```bash
terragrunt run -all --filter 'frontend...' -- plan
```

Output:
```
Unit queue will be processed for plan in this order:
- Unit .terragrunt-stack/db
- Unit .terragrunt-stack/backend
- Unit .terragrunt-stack/frontend

Run Summary  3 units
   Succeeded    3
```

### Run db and all its dependents (reverse graph traversal)

`...db` means "db plus everything that depends on it" (backend and frontend).

```bash
terragrunt run -all --filter '...db' -- plan
```

Output:
```
Unit queue will be processed for plan in this order:
- Unit .terragrunt-stack/db
- Unit .terragrunt-stack/backend
- Unit .terragrunt-stack/frontend

Run Summary  3 units
   Succeeded    3
```

### Apply with filter

```bash
terragrunt run -all --filter 'frontend' -- apply -auto-approve
```

### Destroy with filter

```bash
terragrunt run -all --filter 'frontend' -- destroy -auto-approve
```

---

## Stack Lifecycle Commands

### Generate stack from definition

```bash
terragrunt stack generate
```

### Clean generated stack (remove .terragrunt-stack/)

```bash
terragrunt stack clean
```

### View aggregated outputs

```bash
terragrunt stack output
```

---

## Feature Flags vs Filter Flag

| Approach | Pros | Cons |
|----------|------|------|
| Feature flags (`--feature`) | Defined in HCL, CI/CD friendly, cascading control | Requires exclude blocks in each unit |
| Filter flag (`--filter`) | No HCL changes needed, simple CLI syntax | Ad-hoc only, no default behavior in config |

Use **feature flags** when you want default behavior baked into configs (e.g., always skip frontend in CI).
Use **filter flags** for ad-hoc targeting during development or debugging.

---

## Prod Deployment

```bash
cd prod
terragrunt stack generate
terragrunt run -all -- apply -auto-approve
```

Same feature flags and filter flags work in prod:

```bash
# Deploy only db in prod
terragrunt run -all --feature deploy_backend=false --feature deploy_frontend=false -- apply -auto-approve

# Or using filter
terragrunt run -all --filter 'db' -- apply -auto-approve
```

---

## How It Works

1. `terragrunt.stack.hcl` in dev/ or prod/ defines 3 units with environment-specific values
2. `terragrunt stack generate` copies unit templates into `.terragrunt-stack/` with values
3. Each unit's `terragrunt.hcl` has a `feature` block and `exclude` block
4. When `--feature deploy_X=false` is passed, the exclude condition `!feature.deploy_X.value` becomes true
5. When `--filter 'name'` is passed, only matching units are included in the run queue
6. Excluded units are skipped; dependent units fall back to `mock_outputs`
7. `exclude_dependencies = false` ensures disabling one unit does not cascade to its dependencies
