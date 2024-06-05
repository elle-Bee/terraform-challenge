output "website" {
  value = "${var.teamname}-mist.opstree-war.live"
}

output "s3_bucket_name" {
  value = module.aws_s3_bucket.S3_name
}

output "cloudfront_arn" {
  value = module.cloudfront.cloudfront_arn
}
