# Minimal panic-report fixture.
#
# Run:
#   /projects/gruntwork/terragrunt-4/terragrunt render --working-dir .

engine {
  source = "x"
  meta = {
    secret = sensitive("panic-report-demo")
  }
}
