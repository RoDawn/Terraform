#Provider 설정
provider "ncloud" {
  support_vpc = true
  region      = "KR"
  access_key  = var.access_key
  secret_key  = var.secret_key
}


# VPC 설정
resource "ncloud_vpc" "vpc" {
  name            = var.test #vpc 이름 지정
  ipv4_cidr_block = "10.0.0.0/16"
}


#NACL 설정
resource "ncloud_network_acl" "nacl1" {
  vpc_no      = ncloud_vpc.vpc.id
  // below fields is optional
  name        = "public"
  description = "for test"
}

#NACL 설정
resource "ncloud_network_acl" "nacl2" {
  vpc_no      = ncloud_vpc.vpc.id
  // below fields is optional
  name        = "private"
  description = "for test"
}
