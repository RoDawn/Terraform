#alb 생성
resource "ncloud_lb" "alb" {
  name = "${var.test}-vpc-kr2-alb"
  network_type = "PUBLIC"
  type = "APPLICATION"
  subnet_no_list = [ ncloud_subnet.lb-pub-sb.id ]
}


#lb_target 생성
resource "ncloud_lb_target_group" "alb-tg" {
  vpc_no   = ncloud_vpc.vpc.id
  protocol = "HTTP"
  target_type = "VSVR"
  port        = 80
  description = "for test"
  health_check {
    protocol = "HTTP"
    http_method = "GET"
    port           = 80
    cycle          = 30
    up_threshold   = 2
    down_threshold = 2
  }
  algorithm_type = "RR"
}


resource "ncloud_lb_listener" "alb-lt" {
  load_balancer_no = ncloud_lb.alb.load_balancer_no
  protocol = "HTTP"
  port = 80
  target_group_no = ncloud_lb_target_group.alb-tg.target_group_no
}


resource "ncloud_lb_target_group_attachment" "alb-at" {
  target_group_no = ncloud_lb_target_group.alb-tg.target_group_no
  target_no_list = [for i in ncloud_server.web-server : i.instance_no]
}