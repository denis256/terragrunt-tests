# Panic report example

This directory is a minimal Terragrunt fixture that reproduces a panic and
writes a `terragrunt-crash-*.log` report file.

There is no wrapper script. Run Terragrunt directly from this directory.

## Run

```bash
cd /projects/gruntwork/terragrunt-tests/panic-report
rm -f terragrunt-crash-*.log
/projects/gruntwork/terragrunt-4/terragrunt render --working-dir .
```

The command exits non-zero and prints the panic details in the terminal. That is
expected. The file to inspect is written in this directory.

Use `render`, not `apply`, for this fixture. The panic happens while Terragrunt
renders the config value.

## Inspect the report

List the generated report:

```bash
ls -lt terragrunt-crash-*.log
```

Open the newest report:

```bash
less terragrunt-crash-*.log
```

The file contains:

- timestamp and runtime information
- Terragrunt version and build metadata
- working directory and full command line
- panic message
- stack trace

The command line can contain secrets. Review the file before sharing it.

## Runtime files

Running the example creates files ignored by git:

```text
terragrunt-crash-*.log
```

Clean them with:

```bash
rm -f terragrunt-crash-*.log
```
