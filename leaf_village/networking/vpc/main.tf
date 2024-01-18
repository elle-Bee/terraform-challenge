resource "aws_vpc" "vpc" {
  cidr_block                           = var.ipam_pool_enable ? null : var.vpc_cidr_block
  instance_tenancy                     = var.instance_tenancy
  enable_dns_support                   = var.enable_dns_support
  enable_dns_hostnames                 = var.enable_dns_hostnames
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics
  assign_generated_ipv6_cidr_block     = var.assign_generated_ipv6_cidr_block
  ipv4_ipam_pool_id                    = var.ipam_pool_enable ? var.ipv4_primary_cidr_block_association.ipv4_ipam_pool_id : null
  ipv4_netmask_length                  = var.ipam_pool_enable ? var.ipv4_primary_cidr_block_association.ipv4_netmask_length : null
  ipv6_cidr_block                      = try(var.ipv6_primary_cidr_block_association.ipv6_cidr_block, null)
  ipv6_ipam_pool_id                    = try(var.ipv6_primary_block_association.ipv6_ipam_id, null
  ipv6_netmask_length                  = try(var.ipv6_primary_cidr_block_association.ipv6_netmask_length, null)
  ipv6_cidr_block_network_border_group = var.ipv6_cidr_block_network_border_group
  tags = merge(var.tags,
    {
      Name = format("%s-vpc", var.vpc_name)
    }
  )
}