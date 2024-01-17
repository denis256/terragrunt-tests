
Prepare:

```
for i in {1..100}; do cp -r app_template "app_$i"; done
```

```bash
terragrunt run-all refresh
```

