# Terragrunt tests

Repository with different tests and example usage of Terragrunt

```
docker run --rm -it -v $(pwd):/code -v "$HOME/.ssh:/root/.ssh" --entrypoint /code/container/entrypoint.sh universaldevelopment/tgenv-tfenv:0.0.2
docker run --rm -v $(pwd):/code -v "$HOME/.ssh:/root/.ssh" terragrunt-tests /code/container/auto-run.sh

```