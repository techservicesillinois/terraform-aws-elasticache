resource "aws_elasticache_replication_group" "default" {
  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  automatic_failover_enabled = var.automatic_failover_enabled
  cluster_mode               = var.cluster_mode
  description                = (var.description != null) ? var.description : format("elasticache cluster for %s", var.name)
  engine                     = var.engine
  engine_version             = var.engine_version
  maintenance_window         = var.maintenance_window
  multi_az_enabled           = var.multi_az_enabled
  node_type                  = var.node_type
  num_cache_clusters         = var.num_cache_clusters
  port                       = var.port
  replication_group_id       = var.name
  security_group_ids         = data.aws_security_group.selected.*.id
  snapshot_retention_limit   = var.snapshot_retention_limit
  snapshot_window            = var.snapshot_window
  subnet_group_name          = aws_elasticache_subnet_group.default.id
  tags                       = merge({ Name = var.name }, var.tags)
  transit_encryption_enabled = true
}

resource "aws_elasticache_subnet_group" "default" {
  description = var.description
  name        = format("%s-%s", var.name, var.engine)
  subnet_ids  = local.subnet_ids
  tags        = merge({ Name = var.name }, var.tags)
}
