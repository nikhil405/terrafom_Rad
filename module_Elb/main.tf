resource "aws_elb" "Rad_elb" {
  name            = "${var.name}"
  subnets         = ["${var.subnets}"]
  internal        = "${var.internal}"
  security_groups = ["${var.security_groups}"]
  cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"
  listener     = ["${var.listener}"]
  health_check = ["${var.health_check}"]
}
output "elb_id" {
  value = "${aws_elb.Rad_elb.id}"
}
