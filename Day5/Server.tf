#####Bastion Server#####
resource "ncloud_server" "bastion-server" {
  count = 1
  subnet_no                 = ncloud_subnet.bs-pub-sb.id
  name                      = "${var.test}-pub-bastion-${format("%03d", count.index + 1)}"
  zone                      = "KR-2"
  server_image_product_code = var.os_image
  server_product_code       = var.server_product
  login_key_name            = ncloud_login_key.loginkey.key_name
  network_interface {
    network_interface_no      = ncloud_network_interface.public-server-nic.id
    order                     = 0
  }
}

resource "ncloud_network_interface" "public-server-nic" {
  subnet_no                 = ncloud_subnet.bs-pub-sb.id
  name                      = "bastion-nic"
  access_control_groups     = [ncloud_access_control_group.manager-acg.access_control_group_no]
}

resource "ncloud_public_ip" "public-ip" {
  count = 1
  server_instance_no = ncloud_server.bastion-server[count.index].id
}



#####Private web을 멀티존으로 생성######
resource "ncloud_server" "web-server" {
  count = 2
  subnet_no                 = ncloud_subnet.mz-web-pri-sb[count.index % 2].id
  name                      = "${var.test}-pri-web-${format("%03d", count.index + 1)}"
  server_image_product_code = var.os_image
  server_product_code       = var.server_product
  login_key_name            = ncloud_login_key.loginkey.key_name
  network_interface {
    network_interface_no      = ncloud_network_interface.web-pri-nic[count.index].id
    order                     = 0
  }
}

resource "ncloud_network_interface" "web-pri-nic" {
  count = 2
  subnet_no             = ncloud_subnet.mz-web-pri-sb[count.index % 2].id
  name                  = "web-pri-nic-${count.index + 1}"
  access_control_groups = [
    ncloud_access_control_group.web-acg.access_control_group_no,
    ncloud_access_control_group.manager-acg.access_control_group_no
  ]
}


#####Private was을 멀티존으로 생성######
resource "ncloud_server" "was-server" {
  count = 4
  subnet_no                 = ncloud_subnet.mz-was-pri-sb[count.index % 2].id
  name                      = "${var.test}-pri-was-${format("%03d", count.index + 1)}"
  server_image_product_code = var.os_image
  server_product_code       = var.server_product
  login_key_name            = ncloud_login_key.loginkey.key_name
  network_interface {
    network_interface_no      = ncloud_network_interface.was-pri-nic[count.index].id
    order                     = 0
  }
}

resource "ncloud_network_interface" "was-pri-nic" {
  count = 4
  subnet_no             = ncloud_subnet.mz-was-pri-sb[count.index % 2].id
  name                  = "was-pri-nic-${count.index + 1}"
  access_control_groups = [
    ncloud_access_control_group.was-acg.access_control_group_no,
    ncloud_access_control_group.manager-acg.access_control_group_no
  ]
}