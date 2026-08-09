# Declares an output value named "terraform_execution_role".
output "terraform_execution_role" {

  # Documents what this output represents.
  description = "AWS ARN used by HCP Terraform"

  # Retrieves the ARN returned by the aws_caller_identity data source.
  # This allows us to verify which AWS identity HCP Terraform used during the run.
  value = data.aws_caller_identity.current.arn
}