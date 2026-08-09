output "terraform_execution_role" {
  description = "AWS ARN used by HCP Terraform"
  value       = data.aws_caller_identity.current.arn
}