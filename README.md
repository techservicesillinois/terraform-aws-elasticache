# elasticache

Provides an ElastiCache Replication Group resource. **Currently this module only supports Redis, not memcached**.

Example Usage
----------------

```hcl
module "elasticache" {
  source = "git@github.com:techservicesillinois/terraform-aws-elasticache"

  name       = "service-name"
  redis_failover     = "2"

  network_configuration {
    vpc  = "name-of-vpc"
    tier = "public"
    security_group_names = "service-redis-clients"
  }
}
```

Argument Reference
-----------------

The following arguments are supported:

* `name` - (Required) The name or identifier of the Replication group.  

* `redis_clusters` - (Required) The number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. Defaults to `2`.

* `redis_node_type` - (Required) The compute and memory capacity of the nodes in the node group. Defaults to `cache.t2.small`.

* `redis_failover` - (Optional) Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is disabled for this replication group. Must be enabled for Redis (cluster mode enabled) replication groups. Defaults to `true`.

* `redis_version` - (Optional) The version number of the cache engine to be used for the cache clusters in this replication group. Defaults to `5.0.4`.

* `redis_port` - (Optional) The port number on which each of the cache nodes will accept connections. Defaults to `6379`.

* `apply_immediately` - (Optional) Specifies whether any modifications are applied immediately, or during the next maintenance window. Defaults to `false`.

* `redis_maintenance_window` - (Optional) Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00. Defaults to `fri:08:00-fri:09:00`.

* `redis_snapshot_retention_limit` - (Optional) The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes. Defaults to `0`.

* `redis_snapshot_window` - (Optional) The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period. Example: 05:00-09:00. Defaults to `06:30-07:30`.

network_configuration
-----------------------

A `network_configuration` block supports the following:

* `tier` - (Required) A subnet tier tag (e.g., public, private, nat) to determine subnets to be associated with the task orservice.

* `vpc` - (Required) The name of the virtual private cloud to be associated with the task or service. **NOTE:** Required when using `tier`.

* `security_group_names` - (Required) Additonal security groups to associated with the task or service. This is a space delimited string list of security group names.  

Attributes Reference
--------------------

The following attributes are exported:

* `redis_subnet_group_name` - The name of the cache subnet group to be used for the replication group.
  
* `id` - The replication group identifier. This parameter is stored as a lowercase string.  
  
* `port` - The port number on which each of the cache nodes will accept connections. For Memcache the default is 11211, and for Redis the default port is 6379.

* `endpoint` - The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled.
