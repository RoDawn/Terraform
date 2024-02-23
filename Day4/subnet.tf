#Public subnet을 web전용으로 멀티존으로 생성
resource "ncloud_subnet" "multi_zone_pb_subnet" {
  count = 2

  vpc_no         = ncloud_vpc.vpc.id
  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, count.index + 1)
  zone           = count.index == 0 ? "KR-1" : "KR-2"
  network_acl_no = count.index == 0 ? ncloud_network_acl.nacl1.id : ncloud_network_acl.nacl1.id
  subnet_type    = count.index == 0 ? "PUBLIC" : "PUBLIC"
  name           = "pb-web-sb-${count.index == 0 ? "kr1" : "kr2"}"
  usage_type     = "GEN"
}


#Private subnet을 was전용으로 멀티존으로 생성
resource "ncloud_subnet" "multi_zone_pv_subnet" {
  count = 2

  vpc_no         = ncloud_vpc.vpc.id
  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, count.index + 10)
  zone           = count.index == 0 ? "KR-1" : "KR-2"
  network_acl_no = count.index == 0 ? ncloud_network_acl.nacl2.id : ncloud_network_acl.nacl2.id
  subnet_type    = count.index == 0 ? "PRIVATE" : "PRIVATE"
  name           = "pv-was-sb-${count.index == 0 ? "kr1" : "kr2"}"
  usage_type     = "GEN"
}


##단일 SUBNET 생성
#resource "ncloud_subnet" "subnet1" {
#  vpc_no         = ncloud_vpc.vpc.id
#  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, 1)
#  zone           = "KR-2"
#  network_acl_no = ncloud_network_acl.nacl1.id
#  subnet_type    = "PUBLIC" // PUBLIC(Public) | PRIVATE(Private)
#  // below fields is optional
#  name           = "pb-1"
#  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
#}
#
#
##SUBNET 생성
#resource "ncloud_subnet" "subnet2" {
#  vpc_no         = ncloud_vpc.vpc.id
#  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, 10)
#  zone           = "KR-2"
#  network_acl_no = ncloud_network_acl.nacl2.id
#  subnet_type    = "PRIVATE" // PUBLIC(Public) | PRIVATE(Private)
#  // below fields is optional
#  name           = "pv-1"
#  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
#}
#
#
##Route 연결
#resource "ncloud_route_table" "route_table" {
#  vpc_no                = ncloud_vpc.vpc.id
#  description           = "for test"
#  supported_subnet_type = "PUBLIC"
#}
#
#resource "ncloud_route_table_association" "route_table_subnet" {
#  route_table_no        = ncloud_route_table.route_table.id
#  subnet_no             = ncloud_subnet.subnet1.id
#}

