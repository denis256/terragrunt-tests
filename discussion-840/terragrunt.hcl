locals {
  monitors = {
    "CF-origin-latency" = {
      name = "cloudfront origin latency"
      query = {
        type = "metric_standard"
        params = {
          time_aggr   = "avg"
          time_window = "current_1mo"
          metric      = "aws.cloudfront.origin_latency"
          tags        = "aws_account:1231,environment:staging,application:abc"
          operator    = ">"
          key         = "name"
          function    = "default_zero(avg:aws.cloudfront.origin_latency{*})"
        }
      }
    }
  }

}

inputs = {
  monitors = local.monitors

}