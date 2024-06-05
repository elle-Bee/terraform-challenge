output "bucket_policy" {
  value = aws_s3_bucket_policy.allow_access_from_another_account.policy
}