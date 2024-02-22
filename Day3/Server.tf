#VM 1EA
resource "ncloud_server" "server" {
  subnet_no                 = ncloud_subnet.subnet1.id
  name                      = "test-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
  login_key_name            = ncloud_login_key.loginkey.key_name
  network_interface {
    network_interface_no      = ncloud_network_interface.public-server-nic.id
    order                     = 0
  }
}

resource "ncloud_login_key" "loginkey" {
  key_name = "test-key"
}

resource "ncloud_network_interface" "public-server-nic" {
  subnet_no                 = ncloud_subnet.subnet1.id
  name                      = "test-nic"
  access_control_groups     = [ncloud_access_control_group.manager-acg.access_control_group_no]
}

resource "ncloud_public_ip" "public-ip" {
  server_instance_no = ncloud_server.server.id
}