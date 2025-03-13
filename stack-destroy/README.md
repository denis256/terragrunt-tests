
terragrunt --experiment stacks stack generate

terragrunt --experiment stacks stack run apply

export TG_QUEUE_STRICT_INCLUDE=1
export TG_QUEUE_INCLUDE_DIR="./.terragrunt-stack/unit2"

terragrunt --experiment stacks stack run destroy

