#####Manager-ACG 생성, 관리용#########
resource "ncloud_access_control_group" "manager-acg" {
  name        = "manager-acg"
  description = "관리용 acg"
  vpc_no      = ncloud_vpc.vpc.id
}

resource "ncloud_access_control_group_rule" "manager-acg" {
  access_control_group_no = ncloud_access_control_group.manager-acg.id

  inbound {
    protocol    = "TCP"
    ip_block    = "14.36.20.183/32"
    port_range  = "22"
    description = "My-IP"
  }

  outbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "TEST"
  }

  outbound {
    protocol    = "UDP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "TEST"
  }

  outbound {
    protocol    = "ICMP"
    ip_block    = "0.0.0.0/0"
    description = "TEST"
  }
}


#####WEB-ACG 생성, 관리용#########
resource "ncloud_access_control_group" "web-acg" {
  name        = "web-acg"
  description = "web 전용 acg"
  vpc_no      = ncloud_vpc.vpc.id
}

resource "ncloud_access_control_group_rule" "web-acg" {
  access_control_group_no = ncloud_access_control_group.web-acg.id

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0" #ALB가 있다면 ALB SUBNET IP를 입력한다
    port_range  = "80"
    description = "HTTP"
  }

  outbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "TEST"
  }

  outbound {
    protocol    = "UDP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "TEST"
  }

  outbound {
    protocol    = "ICMP"
    ip_block    = "0.0.0.0/0"
    description = "TEST"
  }
}


#####WAS-ACG 생성, 관리용#########
resource "ncloud_access_control_group" "was-acg" {
  name        = "was-acg"
  description = "was 전용 acg"
  vpc_no      = ncloud_vpc.vpc.id
}

resource "ncloud_access_control_group_rule" "was-acg" {
  access_control_group_no = ncloud_access_control_group.was-acg.id

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0" #WEB IP or NLB가 있다면 NLB SUBNET IP를 입력한다
    port_range  = "8080"
    description = "HTTP"
  }

  outbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "TEST"
  }

  outbound {
    protocol    = "UDP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "TEST"
  }

  outbound {
    protocol    = "ICMP"
    ip_block    = "0.0.0.0/0"
    description = "TEST"
  }
}


#####DB-ACG 생성, 관리용#########
resource "ncloud_access_control_group" "db-acg" {
  name        = "db-acg"
  description = "db 전용 acg"
  vpc_no      = ncloud_vpc.vpc.id
}

resource "ncloud_access_control_group_rule" "db-acg" {
  access_control_group_no = ncloud_access_control_group.db-acg.id

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0" #WAS IP or NLB가 있다면 NLB SUBNET IP를 입력한다
    port_range  = "8080"
    description = "TCP"
  }

  outbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "TEST"
  }

  outbound {
    protocol    = "UDP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
    description = "TEST"
  }

  outbound {
    protocol    = "ICMP"
    ip_block    = "0.0.0.0/0"
    description = "TEST"
  }
}

