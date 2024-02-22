#SUBNET 생성
resource "ncloud_subnet" "subnet1" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, 1)
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
  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, 10)
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.nacl2.id
  subnet_type    = "PRIVATE" // PUBLIC(Public) | PRIVATE(Private)
  // below fields is optional
  name           = "pv-1"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
}


#Route 연결
resource "ncloud_route_table" "route_table" {
  vpc_no                = ncloud_vpc.vpc.id
  description           = "for test"
  supported_subnet_type = "PUBLIC"
}

resource "ncloud_route_table_association" "route_table_subnet" {
  route_table_no        = ncloud_route_table.route_table.id
  subnet_no             = ncloud_subnet.subnet1.id
}