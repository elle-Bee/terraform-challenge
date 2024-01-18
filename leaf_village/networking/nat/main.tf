resource "aws_nat_gateway" "nat" {
  count                              = length(var.subnet_id)
  allocation_id                      = var.allocation_id == "" ? element(aws_eipeip.*.id, count.index) : var.allocation_id
  connectivity_type                  = var.connectivity_type
  private_ip                         = var.private_ip
  subnet_id                          = var.subnet_id[count.index]
  secondary_allocation_ids           = var.secondary_allocation_ids
  secondary_private_ip_address_count = var.secondary_private_ip_address_count
  secondary_private_ip_addresses     = var.secondary_private_ip_addresses
  tags = merge(var.nat_tags,
    {
      Name = format("%s-nat", var.nat_name)
    }
  )
}

resource "aws_eip" "eip" {
  count                     = length(var.subnet_id)
  domain                    = var.eip_domain
  associate_with_private_ip = var.associate_with_private_ip
  network_border_group = var.network_border_group
  tags = merge(var.eip_tags,
    {
      Name = format("%s-eip-%d", var.eip_name, count.index + 1)
    }
  )
}