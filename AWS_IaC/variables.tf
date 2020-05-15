# Variable declaration used in main.tf
variable "aws_region" {}
variable "vpc_cidr" {}
variable "vpc_tag" {}
variable "igw_tag" {}
variable "rtb_pub_tag" {}
variable "rtb_prv_tag" {}
variable "cidrs" {
  type = "map"
}
data "aws_availability_zones" "available" {}
variable "snt_pub1_tag" {}
variable "snt_prv1_tag" {}

