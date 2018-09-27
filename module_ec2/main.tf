# resource "aws_instance" "RAD_production_env" {
# ami = "${var.image_id_RAD}"
# instance_type = "${var.ec2_instance_type}"
# key_name = "${var.aws_key_name}"
# subnet_id = "${var.subnet_id}"
# vpc_security_group_ids = ["${var.security_group}"]
# associate_public_ip_address = "${var.associate_public_ip_address}"
# tags{
#   Name = "${var.instance_name}"
# }
# #Launch configuration of ASG
# }
#
# output "key_name" {
#   value = "${aws_instance.RAD_production_env.id}"
# }
#
# output "id"{
#   value = "${aws_instance.RAD_production_env.id}"
# }
#
# output "ami"{
#   value = "${aws_instance.RAD_production_env.id}"
# }
#
# output "instance_type"{
#   value = "${aws_instance.RAD_production_env.id}"
# }
