#SUBNET 생성
resource "ncloud_subnet" "subnet1" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.0.1.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.nacl1.id
  subnet_type    = "PUBLIC" // PUBLIC(Public) | PRIVATE(Private)
  // below fields is optional
  name           = "pb-1"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
}

#SUBNET 생성
resource "ncloud_subnet" "subnet2" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.0.10.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.nacl2.id
  subnet_type    = "PRIVATE" // PUBLIC(Public) | PRIVATE(Private)
  // below fields is optional
  name           = "pv-1"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
}