locals {
  # Boolean specifying whether to invoke get-subnets module to look up subnets.
  do_subnet_lookup = try(var.network_configuration.subnet_type != null && var.network_configuration.vpc != null, false)

  tags = merge({ Name = var.name }, var.tags)
}

# Look up matching subnets.

module "get-subnets" {
  source = "github.com/techservicesillinois/terraform-aws-util//modules/get-subnets?ref=v3.0.5"

  count       = local.do_subnet_lookup ? 1 : 0
  subnet_type = var.network_configuration.subnet_type
  vpc         = var.network_configuration.vpc
}

locals {
  all_subnets       = distinct(concat(local.module_subnet_ids, try(var.network_configuration.subnet_ids, [])))
  module_subnet_ids = local.do_subnet_lookup ? try(module.get-subnets[0].subnets.ids, []) : []
}

data "aws_security_group" "selected" {
  count = try(length(var.network_configuration.security_group_names), 0)
  name  = var.network_configuration.security_group_names[count.index]
}

# Local variable contains list of security groups from various sources.

locals {
  all_security_groups = distinct(
    concat(
      data.aws_security_group.selected.*.id,
      try(var.network_configuration.security_group_ids, [])
    )
  )
}

resource "aws_elasticache_serverless_cache" "default" {
  ##### FIXME: This needs to be handled.
  #
  #  cache_usage_limits {
  #    data_storage {
  #      maximum = 10
  #      unit    = "GB"
  #    }
  #    ecpu_per_second {
  #      maximum = 5000
  #    }
  # }

  daily_snapshot_time      = var.daily_snapshot_time
  description              = (var.description != null) ? var.description : format("elasticache cluster for %s", var.name)
  engine                   = var.engine
  kms_key_id               = var.kms_key_id
  major_engine_version     = var.major_engine_version
  name                     = var.name
  snapshot_retention_limit = var.snapshot_retention_limit
  security_group_ids       = local.all_security_groups
  subnet_ids               = local.all_subnets
  tags                     = local.tags
}
