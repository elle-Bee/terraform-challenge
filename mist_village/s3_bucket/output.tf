output "bucket_name" {
  value = [for key, bucket in aws_s3_bucket.S3 : bucket.id]
}

output "website_endpoint" {
  value = aws_s3_bucket.S3
}

output "bucket_arns" {
  value = [for key, bucket in aws_s3_bucket.S3 : bucket.arn]
}

output "S3_name" {
  value = aws_s3_bucket.S3
}