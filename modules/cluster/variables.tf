variable "apply_immediately" {
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Specifies whether minor version engine upgrades are applied to the cluster during the maintenance window"
  default     = true
}

variable "automatic_failover_enabled" {
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails"
}

variable "cluster_mode" {
  description = "Specifies whether cluster mode is enabled or disabled"
}

variable "description" {
  description = "Cluster description"
  default     = null
}

variable "engine" {
  description = "Engine"
}

variable "engine_version" {
  description = "Engine version"
}

variable "maintenance_window" {
  description = "Weekly time range for maintenance is performed; format is ddd:hhhh:mm-ddd:hhhh:mm and time is expressed in UTC"
}

variable "multi_az_enabled" {
  description = "Specifies whether to enable multi-AZ support for the replication group"
}

variable "name" {
  description = "Cluster name"
}

variable "network_configuration" {
  description = "Network configuration block"
  type = object({
    security_group_names = optional(list(string), [])
    subnet_type          = string
    vpc                  = string
  })
  default = null
}

variable "node_type" {
  description = "Node (instance) type"
}

variable "num_cache_clusters" {
  description = "Number of nodes to create"
  default     = 2
}

variable "port" {
  description = "Port number on which the cache nodes accepts connections"
  default     = 6379
}

variable "snapshot_window" {
  description = "Daily time range (in UTC) during which a daily snapshot is maken of your cache cluster"
}

variable "snapshot_retention_limit" {
  description = "Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them"
  default     = 7
}

variable "tags" {
  description = "Tags to be applied where supported"
  type        = map(string)
  default     = {}
}
