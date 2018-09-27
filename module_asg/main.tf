resource "aws_launch_configuration" "ec2_production_server" {
  image_id = "${var.image_asg_id}"
  instance_type = "${var.instance_asg_type}"
  security_groups = ["${var.asg_security_groups}"]
  key_name = "${var.aws_key_name_asg}"
  associate_public_ip_address = "${var.associate_public_ip_address_asg}"


lifecycle{
  create_before_destroy = true
}
}

resource "aws_autoscaling_group" "rad_asg" {
launch_configuration = "${aws_launch_configuration.ec2_production_server.id}"
availability_zones = "${var.asg_azs}"
vpc_zone_identifier = ["${var.vpc_zone_identifier_asg}"]
load_balancers            = ["${var.load_balancers}"]
health_check_grace_period = "${var.health_check_grace_period}"
min_size = "${var.asg_min_size}"
max_size = "${var.asg_max_size}"
desired_capacity = "${var.asg_desired_capacity}"
enabled_metrics = "${var.asg_enable_metrics}"
metrics_granularity = "${var.asg_metrics_granularity}"
health_check_type = "${var.asg_health_chk}"
tags {
key = "Name"
value = "RAD_pro_asg"
propagate_at_launch = true
}
}

resource "aws_autoscaling_policy" "RAD_asg_autoscaling_policy" {
name = "RAD_asg_policy"
scaling_adjustment = "${var.asg_adj}"
adjustment_type = "${var.asg_adj_type}"
cooldown = "${var.cd}"
autoscaling_group_name = "${aws_autoscaling_group.rad_asg.name}"
}
