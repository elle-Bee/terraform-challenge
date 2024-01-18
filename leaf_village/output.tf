output "certificate_arn" {
  value = data.aws_acm_certificate.cert.arn
}

output "zoneid" {
  value       = data.aws_route53_zone.hostedzone.id
}