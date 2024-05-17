resource "aws_s3_bucket" "S3" {
  for_each = toset(var.aws_s3_bucket_names)
  bucket = each.key
}

resource "aws_s3_object" "object" {
  bucket       = aws_s3_bucket.S3
  key          = var.key
  content_type = var.content_type
  content      = var.content
}

