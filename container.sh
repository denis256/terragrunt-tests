#!/usr/bin/env bash
# start empty container and copy repository inside
# useful to run tests on "clean" environment
docker run --rm -it -v $(pwd):/code --entrypoint /code/entrypoint.sh universaldevelopment/tgenv-tfenv:0.0.1
