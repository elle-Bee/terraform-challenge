output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}
output "vpc_arn" {
  description = "The arn of the VPC"
  value       = aws_vpc.vpc.arn
}

output "vpc_default_route_table_id" {
  description = "The ID of the route table created by default on VPC creation"
  value = aws_vpc.vpc.default_route_table_id
}

output "vpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value = aws_vpc.vpc.default_security_group_id
}