locals {
  tier                    = "${lookup(var.network_configuration, "tier", "")}"
  vpc                     = "${lookup(var.network_configuration, "vpc", "")}"
  subnets                 = "${compact(split(" ", lookup(var.network_configuration, "subnets", "")))}"
  all_subnets             = "${distinct(concat(flatten(data.aws_subnet_ids.selected.*.ids), local.subnets))}"
  nc_security_group_names = "${compact(split(" ", lookup(var.network_configuration, "security_group_names", "")))}"
}

data "aws_security_group" "selected" {
  count = "${length(local.nc_security_group_names)}"
  name  = "${local.nc_security_group_names[count.index]}"
}

data "aws_vpc" "vpc" {
  count = "${local.tier != "" ? 1 : 0}"

  tags {
    Name = "${local.vpc}"
  }
}

data "aws_subnet_ids" "selected" {
  count  = "${local.tier != "" ? 1 : 0}"
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags {
    Tier = "${local.tier}"
  }
}
