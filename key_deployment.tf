resource "aws_key_pair" "name" {
  key_name   = "ansible"
  public_key = tls_private_key.key.public_key_openssh
}