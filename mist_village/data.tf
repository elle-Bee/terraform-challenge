data "aws_acm_certificate" "cert" {
  provider = aws.cloudfront
  domain   = "*.opstree-war.live"
  statuses = ["ISSUED"]
}
data "aws_route53_zone" "hostedzone" {
  name = var.hosted_zone_name
}