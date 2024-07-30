#!/usr/bin/env bash
rm -rf ./code/apps
rm -rf ./code/deps

mkdir -p code/apps
mkdir -p code/deps


for i in {1..5}
do
   cp -Rfv dependency-template "code/deps/dep-$i"
done

for i in {1..5}
do
   cp -Rfv app-template "code/apps/app-$i"
done
