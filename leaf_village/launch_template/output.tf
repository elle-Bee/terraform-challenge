output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.launch_template.id
}

output "launch_template_latest_version" {
  description = "latest version of the launch template"
  value       = aws_launch_template.launch_template.latest_version
}