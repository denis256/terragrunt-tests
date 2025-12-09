# Git-based Filtering for Terragrunt

Test examples for `--filter` flag with git references
per [issue #4060](https://github.com/gruntwork-io/terragrunt/issues/4060).

## Syntax

### Single Reference

```bash
# Compare to current state, target units changed since previous commit
terragrunt run --filter=[HEAD^1] plan
```

### Commit Range (three-dot syntax)

```bash
# Target units changed between two references
terragrunt run --filter=[main...HEAD] plan
terragrunt run --filter=[a1b2c3d...e4f5g6h] apply
terragrunt run --filter=[trunk...feature-branch] plan
```

### Filter-affected Shorthand

```bash
# Equivalent to --filter=[main...HEAD]
terragrunt run --filter-affected plan
```

## Flags

| Flag                     | Description                             |
|--------------------------|-----------------------------------------|
| `--filter=[ref]`         | Filter units by git reference           |
| `--filter=[ref1...ref2]` | Filter units changed between references |
| `--filter-affected`      | Shorthand for `--filter=[main...HEAD]`  |
| `--filter-allow-destroy` | Allow destroy on removed units          |

## Unit Structure

```
units/
├── vpc/        - Base VPC infrastructure
├── database/   - Database (depends on vpc)
├── cache/      - Redis cache (depends on vpc)
└── app/        - Application (depends on vpc, database)
```

## Test Scenarios

### 1. Apply all units

```bash
cd units && terragrunt run-all apply
```

### 2. Apply only changed units since last commit

```bash
cd units && terragrunt run --filter=[HEAD^1] apply
```

### 3. Apply units changed in feature branch

```bash
cd units && terragrunt run --filter=[main...HEAD] apply
# or
cd units && terragrunt run --filter-affected apply
```

### 4. Handle deleted units

```bash
# When units are removed between branches, use --filter-allow-destroy
cd units && terragrunt run --filter=[main...HEAD] --filter-allow-destroy apply
```

## How It Works

1. Terragrunt compares git refs to identify changed files
2. Maps changed files to affected units
3. Includes dependent units in the run
4. For deleted units: warns unless `--filter-allow-destroy` is set

## Heterogeneous Runs

When filtering across refs where units were deleted, Terragrunt performs "heterogeneous runs":

- Automatically adds `-destroy` flag to operations for removed units
- Enables proper cleanup across branches
