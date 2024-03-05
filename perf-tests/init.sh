#!/usr/bin/env bash

source ./config.sh

for TG_VER in "${versions[@]}"; do
    docker build . -f Dockerfile --build-arg TG_VER=${TG_VER} -t terragrunt-benchmark:${TG_VER}
done