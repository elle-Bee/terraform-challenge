resource "tls_private_key" "private_key" {
  count = var.create_private_key == true ? 1 : 0
  algorithm = var.private_key_algorithm
  rsa_bits  = var.private_key_rsa_bits
}


resource "aws_key_pair" "key_pair" {
  count = var.create_key_pair == true ? 1 : 0
  key_name        = "${var.key_name}-key"
  key_name_prefix = var.key_name == null ? var.key_name_prefix : null
  public_key      = var.create_private_key == true ? trimspace(tls_private_key.private_key[0].public_key_openssh) : var.public_key
  provisioner "local-exec" {
    command = "echo '${tls_private_key.private_key[0].private_key_pem}' > ${var.path}/${var.key_name}.pem"
  }

  tags = var.tags
}