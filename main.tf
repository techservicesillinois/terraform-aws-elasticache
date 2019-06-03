resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "${var.cluster_name}"
  replication_group_description = "${var.cluster_name}"
  number_cache_clusters         = "${var.redis_clusters}"
  node_type                     = "${var.redis_node_type}"
  automatic_failover_enabled    = "${var.redis_failover}"
  engine_version                = "${var.redis_version}"
  port                          = "${var.redis_port}"
  subnet_group_name             = "${aws_elasticache_subnet_group.redis_subnet_group.id}"
  security_group_ids            = ["${data.aws_security_group.selected.*.id}"]
  apply_immediately             = "${var.apply_immediately}"
  maintenance_window            = "${var.redis_maintenance_window}"
  snapshot_window               = "${var.redis_snapshot_window}"
  snapshot_retention_limit      = "${var.redis_snapshot_retention_limit}"
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "${var.cluster_name}-redis"
  subnet_ids = ["${local.all_subnets}"]
}
