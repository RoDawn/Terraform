#MySQL
resource "ncloud_mysql" "mysql" {
  count = 1
  subnet_no = ncloud_subnet.mz-db-pri-sb[count.index].id
  image_product_code = var.db_os_image
  product_code = var.db_product
  service_name = "${var.test}-mysql"
  server_name_prefix = "${var.test}"
  user_name = "${var.test}"
  user_password = "${var.test}1234%"
  host_ip = "%"
  database_name = "${var.test}-db"
}


