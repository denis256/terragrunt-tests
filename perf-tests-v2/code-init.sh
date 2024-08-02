#!/usr/bin/env bash
cd test


rm -rf ./code/apps
rm -rf ./code/deps

mkdir -p code/apps
mkdir -p code/deps

for i in {1..5}
do
    cp -Rfv dependency-template "code/deps/dep-$i"

    # Skip generating a dependency for dep-1
    if [ $i -ne 1 ]; then
        # Define the dependency block to be added
        block=$(cat <<EOF
dependency "dep-1" {
  config_path = "../dep-1"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}
EOF
)
        # Append the block to the specific dependency configuration file
        echo "$block" >> "code/deps/dep-$i/terragrunt.hcl"
    fi
done

for i in {1..30}
do
   cp -Rfv app-template "code/apps/app-$i"
done
