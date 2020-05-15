# This script works with Terraform v0.12.x & above
provider "aws" {
    region = "${var.aws_region}"
}
# VPC definition
resource "aws_vpc" "main_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    enable_dns_support = true

tags = {
    Name = "${var.vpc_tag}"
}
}

# Internet Gateway definition
resource "aws_internet_gateway" "main_igw" {
    vpc_id = "${aws_vpc.main_vpc.id}"
tags = {
    Name = "${var.igw_tag}"
}
}

# Public Route table definition
resource "aws_route_table" "public_rtb" {
    vpc_id = "${aws_vpc.main_vpc.id}"
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main_igw.id}"
}
tags = {
    Name = "${var.rtb_pub_tag}"
}
}
# Default Route table (private) definition
resource "aws_default_route_table" "private_rtb" {
    default_route_table_id = "${aws_vpc.main_vpc.default_route_table_id}"
tags = {
    Name = "${var.rtb_prv_tag}"
}
}

# Public Subnet-1 definition
resource "aws_subnet" "public_subnet_1" {
    vpc_id = "${aws_vpc.main_vpc.id}"
    map_public_ip_on_launch = true
    cidr_block = "${var.cidrs["public-1"]}"
    availability_zone = "${data.aws_availability_zones.available.names[1]}"
tags = {
    Name = "${var.snt_pub1_tag}"
}
}

# Private Subnet-1 definition
resource "aws_subnet" "private_subnet_1"{
    vpc_id = "${aws_vpc.main_vpc.id}"
    cidr_block = "${var.cidrs["private-1"]}"
    map_public_ip_on_launch = false
    availability_zone = "${data.aws_availability_zones.available.names[2]}"
tags = {
    Name = "${var.snt_prv1_tag}"
}
}

#Subnet association definition
resource "aws_route_table_association" "public_snet_1_asc"{
    subnet_id = "${aws_subnet.public_subnet_1.id}"
    route_table_id = "${aws_route_table.public_rtb.id}"
}
resource "aws_route_table_association" "private_snet_1_asc" {
    subnet_id = "${aws_subnet.private_subnet_1.id}"
    route_table_id = "${aws_default_route_table.private_rtb.id}"
}