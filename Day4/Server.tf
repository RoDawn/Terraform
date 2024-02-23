#Public web을 멀티존으로 생성
resource "ncloud_server" "pb-web-server" {
  count                     = 2
  subnet_no                 = ncloud_subnet.multi_zone_pb_subnet[count.index].id
  name                      = "pb-web-${count.index == 0 ? "kr1" : "kr2"}"
  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
  login_key_name            = ncloud_login_key.loginkey.key_name
  network_interface {
    network_interface_no      = ncloud_network_interface.public-server-nic[count.index].id
    order                     = 0
  }
}

resource "ncloud_login_key" "loginkey" {
  key_name = "test-key"
}

resource "ncloud_network_interface" "public-server-nic" {
  count                    = 2
  subnet_no                = ncloud_subnet.multi_zone_pb_subnet[count.index].id
  name                     = "pb-nic-${count.index + 1}"
  access_control_groups    = [ncloud_access_control_group.manager-acg.access_control_group_no]
}

resource "ncloud_public_ip" "public-ip" {
  count               = 2
  server_instance_no  = ncloud_server.pb-web-server[count.index].id
}



#Private web을 멀티존으로 생성
resource "ncloud_server" "pv-was-server" {
  count                     = 2
  subnet_no                 = ncloud_subnet.multi_zone_pv_subnet[count.index].id
  name                      = "pv-was-${count.index == 0 ? "kr1" : "kr2"}"
  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
  login_key_name            = ncloud_login_key.loginkey.key_name
  network_interface {
    network_interface_no      = ncloud_network_interface.private-server-nic[count.index].id
    order                     = 0
  }
}

resource "ncloud_network_interface" "private-server-nic" {
  count                    = 2
  subnet_no                = ncloud_subnet.multi_zone_pv_subnet[count.index].id
  name                     = "test-nic-${count.index + 1}"
  access_control_groups    = [ncloud_access_control_group.was-acg.access_control_group_no]
}




##VM 1EA
#resource "ncloud_server" "server" {
#  subnet_no                 = ncloud_subnet.multi_zone_pb_subnet.id
#  name                      = "test-server"
#  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
#  login_key_name            = ncloud_login_key.loginkey.key_name
#  network_interface {
#    network_interface_no      = ncloud_network_interface.public-server-nic.id
#    order                     = 0
#  }
#}
#
#resource "ncloud_login_key" "loginkey" {
#  key_name = "test-key"
#}
#
#resource "ncloud_network_interface" "public-server-nic" {
#  subnet_no                 = ncloud_subnet.multi_zone_pb_subnet.id
#  name                      = "test-nic"
#  access_control_groups     = [ncloud_access_control_group.manager-acg.access_control_group_no]
#}
#
#resource "ncloud_public_ip" "public-ip" {
#  server_instance_no = ncloud_server.server.id
#}