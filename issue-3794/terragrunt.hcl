errors {
  # Retry block for transient errors
  retry "transient_errors" {
    retryable_errors = [
      "(?s).*cannot create resource \"storageclasses\" in API group.*",
    ]
    max_attempts       = 3
    sleep_interval_sec = 20
  }

  # Ignore block for known safe-to-ignore errors
  ignore "transit_gateway_errors" {
    ignorable_errors = [
      # in the case of sandbox, the TGW attachment may not be present and therefore,
      # the account cannot know about the platform-services TGW
      ".*creating Route in Route Table*"
    ]
    message = "Ignoring transit gateway not found when creating internal route."
  }
}