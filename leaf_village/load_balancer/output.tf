output "alb_dns_name" {
  description = "DNS of ALB"
  value = aws_lb.alb.dns_name
}

output "alb_name" {
  description = "Name of ALB"
  value = aws_lb.alb.name
}
output "alb_arn" {
  description = "ARN of alb"
  value = aws_lb.alb.arn
}

output "alb_http_listener_arn" {
  description = "ARN of alb http listener"
  value = aws_alb_listener.alb_default_listener.arn
}

output "alb_https_listener_arn" {
  description = "ARN of alb https listener"
  value = aws_alb_listener.alb_&httpslistener.*.arnid
}

output "alb_zone" {
  description = "ALB Zone"
  value = aws_lb.alb.zone_id
}