#!/usr/bin/env bash

source ./versions.sh

rm -rf ./results/*.json || true
rm combined_results.json || true

local_versions=(
"/projects/gruntwork/terragrunt/terragrunt"
"/projects/gruntwork/terragrunt-tests/perf-tests-v2/terragrunt-local-cache.sh"
)

executables=()

pwd=$(pwd)

for version in "${versions[@]}"; do
  full_path="${pwd}${local_path}/terragrunt.${version}"
  executables+=("${full_path}")
done

for version in "${local_versions[@]}"; do
  executables+=("${version}")
done

echo "Run:"
mkdir results
for exe in "${executables[@]}"; do
  ./code-init.sh
  id=$(basename "${exe}")
  echo "${id} ${exe}"
  export EXECUTABLE="${exe}"
  hyperfine --runs 5 "./run-test.sh ${id}" --export-json "results/${id}-results.json"
done

# Collect all results into a single JSON file
output_file="combined_results.json"
results=()

for file in results/*.json; do
    entries=$(jq '.results' "$file")
    results+=("$entries")
done

combined_results=$(printf '%s' "${results[@]}" | jq -s 'add')

# Extract the Hyperfine version from the first file processed
first_file="results/$(basename "${executables[0]}")-results.json"
hyperfine_version=$(jq -r '.["hyperfine-version"]' "$first_file")

jq -n --argjson results "$combined_results" --arg version "$hyperfine_version" \
   '{results: $results, "hyperfine-version": $version}' > "$output_file"

echo "Combined results saved to $output_file"
