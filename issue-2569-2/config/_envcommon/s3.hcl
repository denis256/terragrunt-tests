locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  aws_region  = local.region_vars.locals.aws_region

  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment

  # Expose the base source URL so different versions of the module can be deployed in different environments.
  base_source_url = "tfr:///terraform-aws-modules/s3-bucket/aws//.?version=3.10.1"
}

dependency "s3_access_logs" {
  config_path = "${dirname(find_in_parent_folders())}/environments/${local.env}/${local.aws_region}/s3-logging-bucket"

  # Configure mock outputs for the `validate` command that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["init", "validate", "apply", "plan", "destroy", "output"]

  mock_outputs = {
    s3_bucket_id = "temporary-dummy-bucket"
  }
}

inputs = {
  bucket = "lucas-example-bucket-${local.env}"

  versioning = {
    status     = true
    mfa_delete = false
  }

  logging = {
    target_bucket = dependency.s3_access_logs.outputs.s3_bucket_id
    target_prefix = "${local.env}/"
  }

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # Bucket policies
  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true
  attach_elb_log_delivery_policy        = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "aws:kms"
      }
    }
  }
}

