# Declares an AWS data source named "current".
# A data source READS information from AWS rather than creating infrastructure.
data "aws_caller_identity" "current" {}