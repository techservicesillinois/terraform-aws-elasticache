# FIXME: Replace reference to branch with reference to tagged version.

module "get-subnets" {
  source = "github.com/techservicesillinois/terraform-aws-util//modules/get-subnets?ref=v3.0.5"

  count = local.subnet_type != "" ? 1 : 0

  subnet_type = local.subnet_type
  vpc         = local.vpc
}

locals {
  subnet_ids = flatten([for v in module.get-subnets : v.subnets.ids])
  vpc_id     = element(distinct([for v in module.get-subnets : v.vpc.id]), 0)
}

locals {
  subnets                 = compact(split(" ", lookup(var.network_configuration, "subnets", "")))
  subnet_type             = lookup(var.network_configuration, "subnet_type", "")
  vpc                     = lookup(var.network_configuration, "vpc", "")
  all_subnets             = distinct(concat(local.subnet_ids, local.subnets))
  nc_security_group_names = compact(split(" ", lookup(var.network_configuration, "security_group_names", "")))
}

data "aws_security_group" "selected" {
  count = length(local.nc_security_group_names)
  name  = local.nc_security_group_names[count.index]
}
