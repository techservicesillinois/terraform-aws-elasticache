# elasticache

[![Terraform actions status](https://github.com/techservicesillinois/terraform-aws-elasticache/workflows/terraform/badge.svg)](https://github.com/techservicesillinois/terraform-aws-elasticache/actions)

Provides an [AWS ElastiCache](https://aws.amazon.com/elasticache) replication group resource.

**Currently this module only supports the Redis engine.**

Example Usage
----------------

```hcl
module "elasticache" {
  source = "git@github.com:techservicesillinois/terraform-aws-elasticache//modules/cluster"

  engine             = "redis"
  engine_version     = "7.1"

  multi_az_enabled   = true
  name               = "service-name"
  node_type          = "cache.t4g.small"
  num_cache_clusters = 2

  # Maintenance window is expressed in UTC.
  maintenance_window = "fri:08:00-fri:09:00"

  # Snapshot window is expressed in UTC.
  snapshot_window = "06:00-07:00"

  network_configuration = {
    vpc                  = "my-vpc-name"
    subnet_id            = "private"
    security_group_names = ["service-redis-servers"]
  }
}
```

Argument Reference
-----------------

The following arguments are supported:

* `apply_immediately` - (Optional) Specifies whether any modifications are applied immediately, or during the next maintenance window. Defaults to `false`.

* `auto_minor_version_upgrade` - (Optional) Specifies whether minor version engine upgrades are applied to the cluster during the maintenance window. Defaults to `true`.

* `automatic_failover_enabled` - (Optional) Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails.

* `cluster_mode` - (Optional) Specifies whether cluster mode is enabled or disabled. Valid values are `enabled`, `disabled` or `compatible`.

* `description` - (Optional) Description for the replication group.

* `engine` - (Optional) Name of the cache engine to be used for the cluster.

* `engine_version` - (Required) Cache engine version.

* `maintenance_window` - (Required) Specifies the weekly time range (expressed in UTC) for maintenance on the cache cluster.

* `multi_az_enabled` - (Required) Specifies whether to enable multi-AZ support for the replication group.

* `name` - (Required) Cluster name.

* `num_cache_clusters` - (Optional) Number of nodes to create. Defaults to `2`.

* `node_type` - (Required) Instance type of the node group.

* `port` - (Optional) Port number on which the cache nodes accepts connections. Defaults to `6379`.

* `snapshot_retention_limit` - (Optional) Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. Defaults to 7.

* `snapshot_window` - (Required) The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of the cache cluster.

* `tags` - (Optional) Tags to be applied where supported.

network_configuration
-----------------------

A `network_configuration` block supports the following:

* `security_group_names` - (Required) A list of security group names to associate with the task or service.

* `subnet_type` - (Required) Subnet type (e.g., 'campus', 'private', 'public') for resource placement.

* `vpc` - (Required) The name of the virtual private cloud to be associated with the task or service.

Attributes Reference
--------------------

The following attributes are exported:

* `arn` – The ARN of the replication group.

* `configuration_endpoint` - The configuration endpoint address.
