resource "aws_security_group" "RAD_prod_env" {
name = "${var.security_group_for_production}"
vpc_id = "${var.vpc_id}"
ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_security_group" "ELB-sg" {
name = "${var.security_group_for_elb}"
vpc_id = "${var.vpc_id}"
ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}

output "security_group" {
  value = ["${aws_security_group.RAD_prod_env.id}"]
}
