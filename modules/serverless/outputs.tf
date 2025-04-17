output "arn" {
  value = aws_elasticache_serverless_cache.default.arn
}

output "endpoint" {
  value = format("%s:%s", aws_elasticache_serverless_cache.default.endpoint[0].address, aws_elasticache_serverless_cache.default.endpoint[0].port)
}

output "reader_endpoint" {
  value = format("%s:%s", aws_elasticache_serverless_cache.default.reader_endpoint[0].address, aws_elasticache_serverless_cache.default.reader_endpoint[0].port)
}

# Debug outputs.

output "_all_security_groups" {
  value = (var._debug) ? local.all_security_groups : null
}

output "_all_subnets" {
  value = (var._debug) ? local.all_subnets : null
}

