output "bucket_name" {
  value = aws_s3_bucket.S3.id
}

output "website_endpoint" {
  value = aws_s3_bucket.S3
}

output "bucket_arn" {
  value = aws_s3_bucket.S3.arn
}

output "S3_name" {
  value = aws_s3_bucket.bucket
}