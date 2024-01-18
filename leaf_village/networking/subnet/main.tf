resource "aws_subnet" "subnet" {
  count = length(var.availability_zones)
  vpc_id                                         = var.vpc_id
  cidr_block                                     = length(var.cidr_block) != 0 ? var.cidr_block[index] : cidrsubnet(var.vpc_cidr, var.bits != null ? var.bits : 0 , var.netnum != null var.netnum : count.index)
  assign_ipv6_address_on_creation                = var.subnet_ipv6_native ? true : var.assign_ipv6_address_on_creation
  availability_zone                              = element(formatlist("%s%s", var.region, var.availability_zones))
  enable_dns64                                   = var.subnet_ipv6_native ? var.enable_dns64 : false
  enable_resource_name_dns_aaaa_record_on_launch = var.subnet_ipv6_native ? var.enable_resource_name_dns_aaaa_record_on_launch : false
  enable_resource_name_dns_a_record_on_launch    = !var.subnet_ipv6_native ? var.enable_resource_name_dns_a_record_on_launch : false
  ipv6_cidr_block                                = var.subnet_ipv6_native ? var.ipv6_cidr_block : null
  ipv6_native                                    = var.subnet_ipv6_native
  map_public_ip_on_launch                        = var.map_public_ip_on_launch
  private_dns_hostname_type_on_launch            = var.private_dns_hostname_type_on_launch
  tags = merge(var.subnet_tags,
    {
      Name = format("%s-%d", var.subnet_name, count.index + 1)
    }
  )
}
