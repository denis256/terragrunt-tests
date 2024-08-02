#!/bin/bash

# basename dirname


source ./versions.sh

# Base URL for downloading the terragrunt binary
base_url="https://github.com/gruntwork-io/terragrunt/releases/download"

# Loop through each version and download the corresponding binary
for version in "${versions[@]}"; do
    download_url="${base_url}/v${version}/terragrunt_linux_amd64"
    output_file="terragrunt.${version}"

    echo "Downloading terragrunt version ${version}..."
    curl -L -o "${output_file}" "${download_url}"

    if [[ $? -ne 0 ]]; then
        echo "Failed to download terragrunt version ${version}"
    else
        echo "Downloaded terragrunt version ${version} to ${output_file}"
        chmod +x "${output_file}"
    fi
done

echo "All downloads completed."
