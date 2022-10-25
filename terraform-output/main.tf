output "foo" {
  value = "hello1"
}

output "bar" {
  value = tolist([
    "hello1",
    timestamp(),
    "world2",
  ])
}

output "baz" {
  value = {
    greeting: "hello2",
    time: timestamp(),
    subject: "world",
  }
}

