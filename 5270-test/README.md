# Test for Issue #5270: No-color flag not propagated during dependency init

https://github.com/gruntwork-io/terragrunt/issues/5270

## Problem

Colors still apply during init of dependencies even when `--no-color` / `TG_NO_COLOR` is set.

## Structure

```
5270-test/
├── terragrunt.hcl    # Parent module with dependency on y
├── main.tf           # Parent terraform config
├── y/
│   ├── terragrunt.hcl  # Child module
│   └── main.tf         # Child terraform config
└── README.md
```

## How to Test

### 1. Build terragrunt from source (with fix)

```bash
cd /projects/gruntwork/terragrunt-3
go build -o terragrunt .
```

### 2. Run with --no-color flag

```bash
cd /projects/gruntwork/terragrunt-tests/5270-test

# Test with CLI flag
/projects/gruntwork/terragrunt-3/terragrunt run --all apply --no-color --non-interactive --auto-approve 2>&1 | tee output.txt

# Check for ANSI escape codes (should find NONE with fix)
grep -P '\x1b' output.txt && echo "FAIL: Found color codes" || echo "PASS: No color codes"
```

### 3. Run with TG_NO_COLOR env var

```bash
cd /projects/gruntwork/terragrunt-tests/5270-test

# Test with env var
TG_NO_COLOR=true /projects/gruntwork/terragrunt-3/terragrunt run --all apply --non-interactive --auto-approve 2>&1 | tee output-env.txt

# Check for ANSI escape codes (should find NONE with fix)
grep -P '\x1b' output-env.txt && echo "FAIL: Found color codes" || echo "PASS: No color codes"
```

### 4. Cleanup

```bash
cd /projects/gruntwork/terragrunt-tests/5270-test
rm -rf .terragrunt-cache y/.terragrunt-cache output.txt output-env.txt
```

## Expected Results

### Before Fix
Output contains ANSI escape codes like:
```
09:03:54.054 INFO   [y] tofu: ␛[0m␛[1mInitializing the backend...␛[0m␛[0m
```

### After Fix
Output should be clean text without escape codes:
```
INFO   [y] tofu: Initializing the backend...
```

## Quick One-Liner Test

```bash
cd /projects/gruntwork/terragrunt-tests/5270-test && \
rm -rf .terragrunt-cache y/.terragrunt-cache && \
TG_NO_COLOR=true /projects/gruntwork/terragrunt-3/terragrunt run --all plan --non-interactive 2>&1 | \
grep -P '\x1b' && echo "FAIL" || echo "PASS"
```
