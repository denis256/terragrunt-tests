# Hook that produces multi-line diagnostic output (like a real linter would).
# Expected: all lines visible in the error message.
terraform {
  before_hook "policy_check" {
    commands = ["apply", "plan"]
    execute = ["sh", "-c", <<-EOT
      echo 'Policy violations found:' >&2
      echo '  [FAIL] S3 bucket must have encryption enabled (s3_encryption)' >&2
      echo '  [FAIL] S3 bucket must block public access (s3_public_access)' >&2
      echo '  [PASS] S3 bucket must have versioning (s3_versioning)' >&2
      echo '' >&2
      echo '2 violations, 1 passed' >&2
      exit 1
    EOT
    ]
  }
}
