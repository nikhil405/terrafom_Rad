variable "image_asg_id" {
  default = ""
}

variable "instance_asg_type"{
  default = ""
}

variable "asg_security_groups" {
  description = "Security groups"
  type = "list"
}

variable "aws_key_name_asg" {
  default = "{}"
}

variable "associate_public_ip_address_asg" {
  default = true
}

variable "asg_azs" {
  default = []
}

# variable "asg_name" {
#   description = "name of the autoscaling group"
#   default = ""
# }

variable "asg_max_size" {
  default = ""
}

variable "asg_min_size" {
  default = ""
}

variable "vpc_zone_identifier_asg" {

}

variable "asg_desired_capacity" {
  default = ""
}

variable "asg_enable_metrics" {
  default = [""]
}

variable "asg_metrics_granularity" {
  default = ""
}

variable "enable_monitoring" {
  default = false
}

variable "asg_health_chk" {
  default = ""
}

variable "tags"{
  default = ""
}

variable "asg_adj" {
  default = ""
}

variable "asg_adj_type" {
  default = ""
}

variable "cd" {
  default = ""
}
variable "load_balancers" {
  description = "A list of elastic load balancer names to add to the autoscaling group names"
  default     = []
}
variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 300
}
