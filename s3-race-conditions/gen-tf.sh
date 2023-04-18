#!/usr/bin/env bash

for i in {1..100}
do
  echo """
   module \"ecs_service$i\" {
     source = \"git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.4\"
   }
  """
done