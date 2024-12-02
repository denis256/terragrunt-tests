#!/bin/bash
# script which runs successfully only once

MARKER_FILE="marker.txt"

if [[ ! -f "$MARKER_FILE" ]]; then
  echo "Script success"
  touch "$MARKER_FILE"
  exit 0
fi

echo "Script error: failing execution because marker file exists"
exit 1
