#!/usr/bin/env bash

BASE_NAME="project-2-app1"

for i in $(seq -w 1 400)
do
  # Define the target folder name with zero-padded index
  TARGET_FOLDER="${BASE_NAME}-${i}"

  # Copy the source folder to the target folder
  cp -r "$BASE_NAME" "$TARGET_FOLDER"

  echo "Created $TARGET_FOLDER"
done