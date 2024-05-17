variable "S3_name" {
  type = string
}

variable "s3_bucket" {
  type = string
}

variable "cloudfront_arn" {
  type = string
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  type        = string
}