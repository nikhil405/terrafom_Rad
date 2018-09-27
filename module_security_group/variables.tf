variable "tags" {
  default = {}
}
variable "vpc_id" {
  description = "VPC id"
  default = ""
}

variable "security_group_for_production" {
  description = "name for the security group for production server"
  # default = "list"
}

variable "security_group_for_elb" {
  description = "name of the security group for ELB"
  # type = "list"
}
