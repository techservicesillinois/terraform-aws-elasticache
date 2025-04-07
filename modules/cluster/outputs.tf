output "arn" {
  value = aws_elasticache_replication_group.default.arn
}

output "configuration_endpoint" {
  value = aws_elasticache_replication_group.default.configuration_endpoint_address
}

output "primary_endpoint_address" {
  value = aws_elasticache_replication_group.default.primary_endpoint_address
}

output "reader_endpoint_address" {
  value = aws_elasticache_replication_group.default.reader_endpoint_address
}
