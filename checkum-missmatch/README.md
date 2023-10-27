# Check checksums of dependencies

Versions
```
terraform --version
Terraform v1.6.2
on linux_amd64

tofu --version
OpenTofu v1.6.0-alpha3
on linux_amd64
```

Init
```
cd terraform
terraform init

cd tofu
tofu init
```


```
diff terraform/.terraform.lock.hcl tofu/.terraform.lock.hcl 
1c1
< # This file is maintained automatically by "terraform init".
---
> # This file is maintained automatically by "tofu init".
4c4
< provider "registry.terraform.io/hashicorp/aws" {
---
> provider "registry.opentofu.org/hashicorp/aws" {
8,23c8,18
<     "h1:AwjyBYctD8UKCXcm+kLJfRjYdUYzG0hetStKrw8UL9M=",
<     "zh:100966f25b1878b7c4ee250dcbaf09e5a2dad4bcebba2482d77c4cc4e48957da",
<     "zh:57ed5e66949568d25788ebcd170abf5961f81bb141f69d3acca9a7454994d0c5",
<     "zh:5acf55f8901d5443b6994463d7b2dcbb137a242486f47963e0f33c4cce30171a",
<     "zh:7036770df1223d15e0982be39bedf32b2e2cae1eabac717138cbc90bbf94e30e",
<     "zh:79f3f151984a97a7dee14e74ca9d9926b2add30982fe44a450645b89a6da6e00",
<     "zh:8a1b0bc5e237609fc1ad7af17e15a95f93a56c3403c0d022d94163ac1989507c",
<     "zh:94f3baf6a3ba728e31844d6786dae9aa505323389c6323e2eb820a3c81e82229",
<     "zh:9b12af85486a96aedd8d7984b0ff811a4b42e3d88dad1a3fb4c0b580d04fa425",
<     "zh:ac4059a4f45c77432897605efb3642451c125ddddabe14d36a4a85dad13ae6cb",
<     "zh:d2a8d1c9a9100ae3fec34f119d3a90faefb89bf93780fc6934898533c6900cba",
<     "zh:de647167adb585a54cfbfc4c5d204c5d0a444624d386a773eae75789aa75f363",
<     "zh:edb533b3df81f2d1ef7387380cab843877f3f3c756f7a87cbba1961b3f01e4a2",
<     "zh:f56491ecb31b1ebde35cbfe8261e3c82c983b3039837f8756834cf27018bd93a",
<     "zh:fba46b50c35e40ea27947f4305320aaa61cdc22812b138571841e9bf8c7f5db9",
<     "zh:fcb92b5c6fbb70ae9137291ffc8ef06c48daec9cf0fafb980d178fe925658160",
---
>     "h1:nrvJsxhay2nts34LIUgEtFEOe3ORnShNYyDzkybRj0E=",
>     "zh:1d529f875e2a5cbeb80b28c8e3ad41707ec329a7f790a7031868b88705df4965",
>     "zh:22f4b50cf437686cdab64d1d822d80518a846b80ab032b13e25ed5b128a74868",
>     "zh:25b23f38fd9bc0b07d1dad705d8afec0b1d4c6eab4bae7c707c8f7e4caed8856",
>     "zh:5a29c392a116ae44a1ab769efaa699bab5372f3605ec1f1f1749249526a21a76",
>     "zh:65a2177174f91c0382621a5e02fd5b077e9270895a20764bf5784f5d38d54f7b",
>     "zh:6b5b3bdb1134480c7a038287e5e3772298fcebc4cf7c5b0587c9ee61b15e4cb1",
>     "zh:7ec42646e253a29621283aeefd1ec6f1381d166ca6fb3cb7a35a18b05f6f09ef",
>     "zh:8950b9f706533ae017d6776db0ed7d165f8b90ffd1f5f79c91bc93d3a666b5e1",
>     "zh:bd92ded5eafdcc3bd423ca3477f4eec2737e7b6b2ccb68aedc38fd761de20ae8",
>     "zh:d00bd63e362a3ae90d2d9409d2f3adc0198b893637690d6640cc0bcb9b67a066",

```