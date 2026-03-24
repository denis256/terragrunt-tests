terraform {
  required_version = ">= 1.6.0"
}

variable "tag" {
  type    = string
  default = "otel-test"
}

# Basic resource to generate trace spans
resource "null_resource" "trace_test" {
  triggers = {
    always_run = timestamp()
  }

  # Print all env variables to verify TRACEPARENT propagation
  provisioner "local-exec" {
    command = "bash ${path.module}/print-env.sh"
  }
}

# Second resource with dependency to create nested spans
resource "null_resource" "dependent_resource" {
  depends_on = [null_resource.trace_test]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "echo 'Dependent resource executed - check Jaeger for nested spans'"
  }
}

# Data source to add read spans to the trace
data "external" "env_check" {
  program = ["bash", "${path.module}/check-traceparent.sh"]
}

output "traceparent_from_data" {
  value       = data.external.env_check.result["traceparent"]
  description = "TRACEPARENT value captured during plan/apply"
}

output "trace_tag" {
  value = var.tag
}
