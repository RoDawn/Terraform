#load_balancer 전용 pub subnet
resource "ncloud_subnet" "lb-pub-sb" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, 110) #10.0.1.0, web
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.pb-nacl.id
  subnet_type    = "PUBLIC" // PUBLIC(Public) | PRIVATE(Private)
  // below fields is optional
  name           = "${var.test}-vpc-kr2-pub-lb-sub"
  usage_type     = "LOADB"    // GEN(General) | LOADB(For load balancer)
}


#load_balancer 전용 pri subnet
resource "ncloud_subnet" "lb-pri-sb" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, 111) #10.0.1.0, web
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.pv-nacl.id
  subnet_type    = "PRIVATE" // PUBLIC(Public) | PRIVATE(Private)
  // below fields is optional
  name           = "${var.test}-vpc-kr2-pri-lb-sub"
  usage_type     = "LOADB"    // GEN(General) | LOADB(For load balancer)
}


#Public subnet을 bastion전용으로 생성
resource "ncloud_subnet" "bs-pub-sb" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, 200)
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.pb-nacl.id
  subnet_type    = "PUBLIC" // PUBLIC(Public) | PRIVATE(Private)
  // below fields is optional
  name           = "${var.test}-vpc-kr2-pub-sub"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
}

#Private subnet을 web전용으로 멀티존으로 생성
resource "ncloud_subnet" "mz-web-pri-sb" {
  count = 2

  vpc_no         = ncloud_vpc.vpc.id
  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, count.index + 1)
  zone           = count.index == 0 ? "KR-1" : "KR-2"
  network_acl_no = count.index == 0 ? ncloud_network_acl.pv-nacl.id : ncloud_network_acl.pv-nacl.id
  subnet_type    = count.index == 0 ? "PRIVATE" : "PRIVATE"
  name           = "${var.test}-vpc-${count.index == 0 ? "kr1" : "kr2"}-web-pri-sub"
  usage_type     = "GEN"
}


#Private subnet을 was전용으로 멀티존으로 생성
resource "ncloud_subnet" "mz-was-pri-sb" {
  count = 2

  vpc_no         = ncloud_vpc.vpc.id
  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, count.index + 10)
  zone           = count.index == 0 ? "KR-1" : "KR-2"
  network_acl_no = count.index == 0 ? ncloud_network_acl.pv-nacl.id : ncloud_network_acl.pv-nacl.id
  subnet_type    = count.index == 0 ? "PRIVATE" : "PRIVATE"
  name           = "${var.test}-vpc-${count.index == 0 ? "kr1" : "kr2"}-was-pri-sub"
  usage_type     = "GEN"
}


#Private subnet을 db 전용으로 멀티존으로 생성
resource "ncloud_subnet" "mz-db-pri-sb" {
  count = 2

  vpc_no         = ncloud_vpc.vpc.id
  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, count.index + 100)
  zone           = count.index == 0 ? "KR-1" : "KR-2"
  network_acl_no = count.index == 0 ? ncloud_network_acl.pv-nacl.id : ncloud_network_acl.pv-nacl.id
  subnet_type    = count.index == 0 ? "PRIVATE" : "PRIVATE"
  name           = "${var.test}-vpc-${count.index == 0 ? "kr1" : "kr2"}-db-pri-sub"
  usage_type     = "GEN"
}

