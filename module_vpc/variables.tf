variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "0.0.0.0/0"
}

variable "vpc_name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  default = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type = "list"
}

variable "azs" {
  description = "A list of availability zones in the region"
  default = []
}

variable "internet_gateway" {
  description = "attaching an internet gateway"
  default = []
}

variable "igw_name" {
  description = "Internet gateway name"
  default = ""
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  default = ""
}

variable "aws_route_table" {
  description = "route table association"
  default = ""
}
