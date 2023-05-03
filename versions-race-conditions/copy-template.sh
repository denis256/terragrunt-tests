#!/usr/bin/env bash

rm -rf project/dep
mkdir project/dep

#mkdir -p apps/app-0
#cp terragrunt0.hcl apps/app-0/terragrunt.hcl

for i in {1..25}
do
   cp -Rfv dep-template "project/dep/dep-$i"
done

for i in {1..25}
do
   echo "dependency \"dep_$i\" { "
   echo "config_path = \"../dep/dep-$i\" "
   echo "mock_outputs_allowed_terraform_commands = [\"validate\"] "
   echo "  mock_outputs = { "
   echo "  vpc_id = \"fake-vpc-id\" "
   echo "  } "
   echo "}"
done



#echo "dependencies {
#        paths = [ "
#
#for i in {1..25}
#do
#   echo "\"../dep/dep-$i\","
#
#done
#
#echo "]
#            }"