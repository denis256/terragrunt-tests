# Cache module (Redis)
resource "local_file" "cache" {
  content  = "cache-config"
  filename = "${path.module}/cache.txt"
}

output "cache_endpoint" {
  value = "redis.example.com:6379"
}
