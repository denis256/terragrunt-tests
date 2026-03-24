# OpenTofu OpenTelemetry Tracing Test

Verify that OpenTofu produces OpenTelemetry traces and passes `TRACEPARENT` env variable to local-exec provisioners.

## Prerequisites

- OpenTofu >= 1.6.0
- Docker (for Jaeger)

## Steps

### 1. Start Jaeger

```bash
docker run \
  --rm \
  --name jaeger \
  -e COLLECTOR_OTLP_ENABLED=true \
  -p 16686:16686 \
  -p 4317:4317 \
  -p 4318:4318 \
  jaegertracing/all-in-one:1.54.0
```

### 2. Configure OpenTelemetry

```bash
export OTEL_TRACES_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317
export OTEL_EXPORTER_OTLP_INSECURE=true
```

### 3. Run OpenTofu

```bash
tofu init
tofu apply -auto-approve
```

### 4. Check results

- **Console output**: look for `TRACEPARENT` in the local-exec output - if set, OpenTofu propagates trace context to child processes
- **Jaeger UI**: open http://localhost:16686, select service `opentofu`, view traces for init/apply operations
- **Nested spans**: the dependent resource should appear as a child span under the apply trace

### 5. Cleanup

```bash
tofu destroy -auto-approve
docker stop jaeger
```

## What to look for

| Check | Where | Expected |
|---|---|---|
| Traces appear | Jaeger UI | Service `opentofu` with plan/apply spans |
| TRACEPARENT set | Console output from print-env.sh | Non-empty value like `00-<trace-id>-<span-id>-01` |
| Nested spans | Jaeger trace detail | `dependent_resource` span nested under apply |
| Data source span | Jaeger trace detail | External data source read span visible |
