inputs = {
  bucket_policy_statements = {
    DenyUnEncryptedObjectUploads = {
      effect  = "Deny"
      actions = ["s3:PutObject"]
      keys = [
        "",
        "/*"
      ]
      principals = {
        AWS = ["*"]
      }
      condition = {
        RequireSSE = {
          test     = "StringNotEquals"
          variable = "aws:kms"
          values   = ["s3:x-amz-server-side-encryption"]
        }
      }
    }
  }
}