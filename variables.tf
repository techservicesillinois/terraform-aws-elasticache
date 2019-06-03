variable "cluster_name" {
 description = "REQUIRED: The name of the cluster. Should reflect the service utilizing redis."
}

variable "redis_clusters" {
  description = "Number of Redis cache clusters (nodes) to create"
  default = "2"
}

variable "redis_node_type" {
  description = "Instance type to use for creating the Redis cache clusters"
  default     = "cache.t2.small"
}

variable "redis_failover" {
  default = "true"
}

variable "redis_version" {
  description = "Redis version to use, defaults to 3.2.10"
  default     = "3.2.10"
}

variable "redis_port" {
  default = 6379
}

# variable "security_group_ids" {
#   type        = "list"
#   default     = []
#   description = "A list of server side security groups"
# }

variable "apply_immediately" {
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false."
  default     = "false"
}

variable "redis_maintenance_window" {
  description = "Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period"
  default     = "fri:08:00-fri:09:00"
}

variable "redis_snapshot_window" {
  description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period"
  default     = "06:30-07:30"
}

variable "redis_snapshot_retention_limit" {
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes"
  default     = 0
}

### NETWORK CONFIGURATION block
variable "network_configuration" {
  description = "A network configuration block"
  default     = {}
}
