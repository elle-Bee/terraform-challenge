resource "aws_route_table_association" "subnet_associate" {
  count = length(var.subnet_id)
  subnet_id =  var.subid[count.index]
  route_table_id = route_table_id
}