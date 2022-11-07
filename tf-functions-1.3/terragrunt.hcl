inputs = {
  startswith1 = startswith("hello world", "hello")
  startswith2 = startswith("hello world", "qwe")
  endswith1 = endswith("hello world", "hello")
  endswith2 = endswith("hello world", "world")

  //value = chomp("hello\n")
}