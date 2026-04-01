# include-in-copy test

Test `include_in_copy` feature - copies `config.txt` from parent directory into terragrunt source cache so tofu/terraform can read it via `file()`.

## Structure

```
include-in-copy/
  config.txt          # file to be copied into source dir
  app/
    main.tf           # reads config.txt via file() function
    terragrunt.hcl    # source=parent, include_in_copy=["config.txt"]
```

## How it works

- `source = "${get_terragrunt_dir()}//.."` points to parent as terraform module source
- `include_in_copy = ["config.txt"]` ensures `config.txt` is copied into `.terragrunt-cache`
- `main.tf` reads `config.txt` using `file()` and creates `output.txt` with its content

## Run

```bash
cd app
rm -rf .terragrunt-cache
terragrunt run plan
terragrunt run apply

# verify config.txt was copied
tree .terragrunt-cache -a | grep config.txt

# check output
terragrunt run output -raw config
```
