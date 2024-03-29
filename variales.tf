variable "instance_type" {
  default = "t2.micro"
}

variable "server_name" {
  type    = list(any)
  default = ["api", "dotnet", "db"]
}