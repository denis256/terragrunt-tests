# sops encryption test

Test for decrypting yaml files with sops

Used keys:
```
# public key: age106dn94074uskzjua39h4v0ql89l528wrqp2f84xpcznpr9f6ye4q9k8hp8
#AGE-SECRET-KEY-1YQMYYAHGUU5VK67GKY6RM8YEKTW687RT9KPUG5X8FD0F988PCXKQXM8RMY

export SOPS_AGE_KEY_FILE=keys.txt
```
Sops cli:
```
sops --encrypt --age age106dn94074uskzjua39h4v0ql89l528wrqp2f84xpcznpr9f6ye4q9k8hp8 file.yaml > file.enc.yaml
sops -d file.enc.yaml
```
Test:
```
terragrunt apply
cat secret_value.txt
```