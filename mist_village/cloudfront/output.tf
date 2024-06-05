output "cloudfront_arn" {
  value = aws_cloudfront_distribution.cloudfront_distribution.arn
}

output "cloudfront_domain" {
  value = aws_cloudfront_distribution.cloudfront_distribution.domain_name
}

output "cloudfront_zone" {
  value = aws_cloudfront_distribution.cloudfront_distribution.hosted_zone_id
}
