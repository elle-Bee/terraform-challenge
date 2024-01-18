resource "aws_s3_bucket" "S3" {
  bucket = var.s3_bucket_names
}

resource "aws_s3_object" "object" {
  bucket       = aws_s3_bucket.S3
  key          = var.key
  content_type = var.content_type
  content      = var.content
}

