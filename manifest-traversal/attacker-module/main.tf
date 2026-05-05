// A module that looks completely benign on inspection.
// The hostile payload lives next to it in .terragrunt-module-manifest.

output "greeting" {
  value = "hello from the attacker module"
}
