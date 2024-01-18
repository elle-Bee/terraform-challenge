resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = var.S3_name
  policy = data.aws_iam_policy_document.website_policy.json
}


data "aws_iam_policy_document" "website_policy" {
  statement {
    sid       = "AllowCloudFrontServicePrincipal"
    effect    = "Allow"
    resources = ["${var.s3_bucket_arn}/*"]
    actions   = ["s3:GetObject"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = ["${var.cloudfront_arn}"]
    }

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
  }
}
