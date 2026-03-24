# OpenTofu OpenTelemetry Tracing Test

Verify that OpenTofu produces OpenTelemetry traces and passes `TRACEPARENT` env variable to local-exec provisioners.

## Steps


### Configure OpenTelemetry

```bash
export OTEL_TRACES_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317
export OTEL_EXPORTER_OTLP_INSECURE=true
```

### Run OpenTofu

```bash
tofu init
tofu apply -auto-approve
```

### Check results

- **Console output**: look for `TRACEPARENT` in the local-exec output - if set, OpenTofu propagates trace context to child processes

