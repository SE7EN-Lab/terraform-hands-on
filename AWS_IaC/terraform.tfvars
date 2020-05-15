# Default values of vairables used in main.tf
aws_region = "ap-south-1"
vpc_cidr = "10.0.0.0/16"
vpc_tag = "iac_main_vpc"
igw_tag = "iac_main_igw"
rtb_pub_tag = "iac_public_rtb"
rtb_prv_tag = "iac_private_rtb"
cidrs = {
    public-1 = "10.0.1.0/24"
    private-1 = "10.0.2.0/24"
}
snt_pub1_tag = "iac_public_snt_1"
snt_prv1_tag = "iac_privare_snt_1"