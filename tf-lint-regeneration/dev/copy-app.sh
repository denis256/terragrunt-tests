#!/usr/bin/env bash

rm -rf apps
mkdir apps

#mkdir -p apps/app-0
#cp terragrunt0.hcl apps/app-0/terragrunt.hcl

for i in {1..100}
do
   cp -Rfv template "apps/app-$i"
   # substitue app
   # if i is odd
    if [ $(($i % 2)) -eq 1 ]
    then
        app="$(($i - 1))"
    else
        app="$(($i - 2))"
    fi

   APP="${app}" envsubst < "apps/app-$i/terragrunt.hcl" > "apps/app-$i/terragrunt.hcl.tmp"
   mv "apps/app-$i/terragrunt.hcl.tmp" "apps/app-$i/terragrunt.hcl"

done
