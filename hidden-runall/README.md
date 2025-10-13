```

# should fail
terragrunt run --all --non-interactive -- apply

terragrunt run --all --queue-include-dir "**/.cloud/**/**"  --non-interactive -- apply 
TG_QUEUE_INCLUDE_DIR="**/.cloud/**/**" terragrunt run --all --non-interactive -- apply 
```