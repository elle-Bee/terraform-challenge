output "website" {
  value = "${var.teamname}-mist.opstree-war.live"
}

output "S3_bucket_name" {
  value = module.bucket.S3_name
}

output "cloudfront_arn" {
  value = module.cdn.cloudfront_arn
}
