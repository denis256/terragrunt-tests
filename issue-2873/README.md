
```
docker build . -t issue-2873
docker run -it --entrypoint /bin/bash issue-2873
```

Find and run docker container
```
cd ..
export dir="$(pwd)"

find "$dir" -mindepth 2 -name "terragrunt.hcl" -printf "%h\n" | \
  grep -e .terragrunt-cache -v | \
  xargs -P 50 -I {} docker run -v $dir:$dir -t -e DISABLE_BACKEND=true  issue-2873 terragrunt --terragrunt-download-dir /tmp/terragrunt-cache --terragrunt-working-dir {} validate

```