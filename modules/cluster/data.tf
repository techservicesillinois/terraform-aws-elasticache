module "get-subnets" {
  source = "github.com/techservicesillinois/terraform-aws-util//modules/get-subnets?ref=v3.0.5"

  count = local.do_subnet_lookup ? 1 : 0

  subnet_type = var.network_configuration.subnet_type
  vpc         = var.network_configuration.vpc
}

locals {
  do_subnet_lookup = try(var.network_configuration.subnet_type != null && var.network_configuration.vpc != null, false)
  subnet_ids       = flatten([for v in module.get-subnets : v.subnets.ids])
  vpc_id           = element(distinct([for v in module.get-subnets : v.vpc.id]), 0)
}

data "aws_security_group" "selected" {
  count = try(length(var.network_configuration.security_group_names), 0)
  name  = var.network_configuration.security_group_names[count.index]
}
