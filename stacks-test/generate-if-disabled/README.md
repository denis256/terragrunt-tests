# Test case for generation issues


cd live
terragrunt stack run apply
terragrunt stack run plan --non-interactive --filter 'second | type=unit'