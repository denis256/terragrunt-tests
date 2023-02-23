#!/usr/bin/env bash

rm -rf apps
mkdir apps

for i in {1..20}
do
   cp -Rfv app-template "apps/app-$i"
done
