# Création clé privé
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "name" {
  content  = tls_private_key.key.private_key_pem
  filename = "${path.module}/keys/private_key.pem"
}
data "template_file" "user_data" {
  count    = length(var.server_name)
  template = file("${path.module}/cloud-init.yaml")
  vars = {
    hostname = "${var.server_name[count.index]}"
  }
}
resource "aws_instance" "name" {
  count                  = length(var.server_name)
  ami                    = "ami-0c1c30571d2dae5c9"
  instance_type          = var.instance_type
  key_name               = aws_key_pair.name.id
  availability_zone      = "eu-west-1a"
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data              = data.template_file.user_data[count.index].rendered
  tags = {
    Name = var.server_name[count.index]
  }
}