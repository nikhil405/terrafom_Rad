resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
  tags {
    Name = "${var.igw_name}"
  }
}

resource "aws_subnet" "public" {
  count = "${length(var.public_subnets) > 0 ? length(var.public_subnets) : 0}"
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  tags = {
    Name = "${var.vpc_name}-${var.public_subnet_tags}-${element(var.azs, 0)}"
  }
}

resource "aws_subnet" "private" {
  count = "${length(var.private_subnets) > 0 ? length(var.private_subnets) : 0}"
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  tags = {
    Name = "${var.vpc_name}-${var.private_subnet_tags}-${element(var.azs, 1)}"
  }
}

resource "aws_route_table" "public" {
  count = "${length(var.public_subnets) > 0 ? 1 : 0}"
  vpc_id = "${aws_vpc.default.id}"
  tags = {
    Name = "${var.vpc_name}-${var.public_route_table_tags}"
  }
}

resource "aws_route" "public_internet_gateway" {
  count = "${length(var.public_subnets) > 0 ? 1 : 0}"
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

resource "aws_route_table_association" "public" {
  count = "${length(var.public_subnets) < 1 ? length(var.public_subnets) : 1}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

output "vpc_id" {
  value = "${aws_vpc.default.id}"
}
output "public_subnet_id" {
  value = "${aws_subnet.public.*.id}"
}
output "route_table_id"{
  value = "${aws_route_table.public.*.id}"
}
output "gateway_id"{
  value = "${aws_internet_gateway.default.id}"
}
output "private_subnet_id" {
  value = "${aws_subnet.private.*.id}"
}
