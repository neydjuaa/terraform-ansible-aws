output "public_ip" {
  
  value = "${zipmap(aws_instance.name[*].tags.Name, aws_instance.name[*].public_ip)}"

  
}

