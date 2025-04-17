# elasticache (serverless)

[![Terraform actions status](https://github.com/techservicesillinois/terraform-aws-elasticache/workflows/terraform/badge.svg)](https://github.com/techservicesillinois/terraform-aws-elasticache/actions)

Provides a serverless [AWS ElastiCache](https://aws.amazon.com/elasticache/) resource.

**Currently this module only supports the Redis engine.**

Example Usage
----------------

```hcl
module "elasticache" {
  source = "git@github.com:techservicesillinois/terraform-aws-elasticache//modules/serverless"

  # Snapshot time is expressed in UTC.
  daily_snapshot_time      = "06:00"
  engine                   = "redis"
  major_engine_version     = "7.1"
  name                     = "service-name"
  snapshot_retention_limit = 14

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

* `daily_snapshot_time` - (Required) Time at which daily snapshots will be created.

* `description` - (Optional) Cache description.

* `engine` - (Required) Cache engine name (e.g., `redis`).

* `kms_key_id` - (Optional) ARN of the KMS key for encryption at rest; if no key is provided, a default KMS key is used

* `major_engine_version` - (Required) Cache engine major version.

* `name` - (Required) Cache name.

* `network_configuration` - (Optional) A [network configuration](#network_configuration) block is used to define  placement of the serverless cache.

* `snapshot_retention_limit` - (Optional) Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. Defaults to 7.

* `tags` - (Optional) Tags to be applied where supported.

network_configuration
-----------------------

A `network_configuration` block supports the following:

* `security_group_ids` - (Optional) A list of security group IDs to associate with the service.

* `security_group_names` - (Optional) A list of security group names to associate with the service.

* `subnet_ids` - (Optional)

* `subnet_type` - (Optional) Subnet type (e.g., 'campus', 'private', 'public') for resource placement.

* `vpc` - (Required) The name of the virtual private cloud to be associated with the task or service.

Attributes Reference
--------------------

The following attributes are exported:

* `arn` – The ARN of the serverless cache.

* `endpoint` - The endpoint address for the serverless cache.

* `reader_endpoint` - The read-only endpoint address for the serverless cache.

