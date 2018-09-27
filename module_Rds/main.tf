resource "aws_db_subnet_group" "Rad_db" {
  count = "${var.create ? 1 : 0}"

  name_prefix = "${var.name_prefix}"
  description = "Database subnet group for ${var.db_subnetgroup_identifier}"
  subnet_ids  = ["${var.subnet_ids}"]
}
