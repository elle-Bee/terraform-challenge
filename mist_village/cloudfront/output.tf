output "cloudfront_domain" {
  value = aws_cloudfront_distribution.cloudfront_distribution.domain
}

output "cloudfront_zone" {
  value = aws_cloudfront_distribution.cloudfront_distribution.hosted_zone_id
}

output "cloudfront_arn" {
  value = aws_cloudfront_distribution.cloudfront_distribution
}