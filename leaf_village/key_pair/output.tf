output "key_pair_name" {
  description = "key name"
  value       = aws_key_pair.key_pair.*.key_name[0]
}