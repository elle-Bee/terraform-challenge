resource "aws_lb" "load" {
  name               = "${var.alb_name}-alb"
  internal           = var.internal
  load_balancer_type = application
  security_groups    = var.security_groups_id
  subnets            = var.subnets_id
  enable_deletion_protection = var.enable_deletion_protection 

  tags = merge(
    {
      "Name" = format("%s-alb", var.alb_name)
    },
    var.tags,
  )

   dynamic "access_logs"{
    for_each = var.enable_logging == true ? local.accesslogsinfo : [{}]
    iterator = logs_value
    content {
    bucket  = logs_value.value.bucket
    prefix  = logs_value.value.prefix
    enabled = logs_value.value.enabled
    }
  }
}

locals {
  access_logs_info = [
    {
    bucket  = var.logs_bucket
    prefix  = format("%s-alb", var.alb_name)
    enabled = var.enable_logging
    }
  ]
}

resource "aws_alb_listener_rule" "alb_listener_rule" {
  listener_arn = aws_alb_listener.alb_default_listener.arn
  priority     = 100

  action {
    type = "redirect"
  redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
  }
  }

  condition {
    host_header {
      values = var.host_header_value
    }
  }
}

resource "aws_alb_listener" "alb_default_listener" {
  load_balancer_arn = aws_lb.alb.arn  
  port    = 80
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "503 Service Unavailable"
      status_code  = "503"
    }
  }
}


resource "aws_alb_listener" "alb_https_listener" { 
  load_balancer_arn = aws_lb.alb.arn  
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.alb_certificate_arn

 default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}