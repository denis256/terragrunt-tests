#!/bin/bash
# Script to print OpenTelemetry-related environment variables
# Used by local-exec provisioner to verify trace context propagation

echo "=== OpenTelemetry Environment Variables ==="
env | grep -i "otel\|traceparent\|tracestate\|trace" | sort
echo ""
echo "=== TRACEPARENT value ==="
echo "TRACEPARENT=${TRACEPARENT:-not set}"
echo ""

