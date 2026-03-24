#!/bin/bash
# Capture TRACEPARENT from env, output as JSON for external data source
val=$(env | grep "^TRACEPARENT=" | cut -d= -f2-)
echo "{\"traceparent\": \"${val:-none}\"}"
