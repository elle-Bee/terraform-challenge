resource "aws_lb_target_group" "target_group" {
  name        = "${var.applicaton_name}-alb-tg"
  port        = var.applicaton_port
  target_type = var.tg_target_type
  protocol    = var.target_protocol
  vpc_id      = var.vpc_id
  health_check {
    path = var.applicaton_health_check_target
  }
}
