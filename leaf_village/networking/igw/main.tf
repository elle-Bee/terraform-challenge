resource "aws_internet_gateway" "IGW" {
  vpc_id = var.vpc_id
  tags = merge(var.igw_tags,
    {
      Name = format("%s-igw", var.igw_name)
    }
  )
}
