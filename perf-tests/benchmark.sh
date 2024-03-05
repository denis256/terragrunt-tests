#!/usr/bin/env bash

source ./config.sh

COMMAND="terragrunt graph-dependencies"

for TG_VER in "${TG_VERS[@]}"; do
    echo Run Terragrunt version ${TG_VER}
    $c run --rm -v "$(pwd)/code:/code" -v "$(pwd):/output" terragrunt-benchmark:${TG_VER} /usr/bin/time -ao /output/result.tg${TG_VER}.txt ${COMMAND}
done