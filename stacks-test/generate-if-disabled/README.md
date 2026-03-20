# Test case for generation issues


cd live
terragrunt stack run apply
terragrunt stack run plan --non-interactive --filter 'second | type=unit'


```

❯ terragrunt stack run plan --non-interactive --filter 'second | type=unit'
[INFO] Getting version from tgenv-version-name
[INFO] TGENV_VERSION is 0.99.4
07:15:55.704 INFO   Generating unit second from ./terragrunt.stack.hcl
07:15:55.704 INFO   Generating unit first from ./terragrunt.stack.hcl
07:15:55.708 INFO   Generating unit second from ./terragrunt.stack.hcl
07:15:55.708 INFO   Generating unit first from ./terragrunt.stack.hcl
07:15:55.713 INFO   Unit queue will be processed for plan in this order:
- Unit .terragrunt-stack/second

╷
│ Error: Duplicate required providers configuration
│ 
│   on beta.tf line 2, in terraform:
│    2:   required_providers {
│ 
│ A module may have only one required providers configuration. The required
│ providers were previously configured at alpha.tf:2,3-21.
```