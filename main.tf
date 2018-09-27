terraform {
  required_version = "v0.11.8"
}

module "vpc" {
  source = "module_vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "RAD_test_vpc"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  azs = ["ap-south-1a", "ap-south-1b"]
  public_subnet_tags = "public_subnet"
  private_subnet_tags = "private_subnet"
  internet_gateway = "aws_internet_gateway"
  igw_name = "RAD-IGW"
  public_route_table_tags = "public-route_table"
}

module "security_group_production_server" {
  source = "module_security_group"
  security_group_for_production = "RAD-Production-SG"
  vpc_id = "${module.vpc.vpc_id}"
  security_group_for_elb = "RAD-ELB-SG"
}

# module "ec2-config" {
#   source = "module_ec2"
#   image_id_RAD = "ami-04ea996e7a3e7ad6b"
#   ec2_instance_type = "t2.micro"
#   aws_key_name = "terra"
#   aws_key_path = "/home/qwinix/Downloads"
#   security_group = "${module.security_group_production_server.security_group}"
#   subnet_id = "${module.vpc.public_subnet_id[0]}"
#   route_table_id = "${module.vpc.route_table_id[0]}"
#   instance_name = "RAD_production_env"
#   associate_public_ip_address = true
# }

module "asg-config"{
  source = "module_asg"
  image_asg_id = "ami-04ea996e7a3e7ad6b"
  instance_asg_type = "t2.micro"
  asg_security_groups = ["${module.security_group_production_server.security_group}"]
  aws_key_name_asg = "autoscldemo"
  associate_public_ip_address_asg = true
  asg_azs = ["ap-south-1a", "ap-south-1b"]
  vpc_zone_identifier_asg = "${module.vpc.public_subnet_id[0]}"
  load_balancers            = ["${module.elb-config.elb_id}"]
  asg_min_size = 1
  asg_max_size = 1
  asg_desired_capacity = 1
  asg_enable_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
  asg_metrics_granularity = "1Minute"
  asg_health_chk = "ELB"
  asg_adj = 1
  asg_adj_type = "ChangeInCapacity"
  cd = 300
}
module "elb-config" {
  source = "module_Elb"
  name = "Rad-Production-elb"
  subnets = ["${module.vpc.public_subnet_id[0]}"]
  security_groups = ["${module.security_group_production_server.security_group}"]
  internal = false
  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    }
  ]
  health_check = [
    {
      target              = "HTTP:80/"
      interval            = 30
      healthy_threshold   = 10
      unhealthy_threshold = 2
      timeout             = 5
    }]
}
