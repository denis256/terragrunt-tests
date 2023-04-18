#!/usr/bin/env bash

rm -rf project/dep
mkdir project/dep

#mkdir -p apps/app-0
#cp terragrunt0.hcl apps/app-0/terragrunt.hcl

for i in {1..100}
do
   cp -Rfv dep-template "project/dep/dep-$i"
done

echo "dependencies {
        paths = [ "

for i in {1..100}
do
   echo "\"../dep/dep-$i\","

done

echo "]
            }"