# Opens the Terraform configuration block.
# This block configures Terraform itself rather than an AWS resource.
terraform {

  # Requires this project to run with Terraform version 1.12.2 or newer.
  # This prevents someone using an older incompatible Terraform version.
  required_version = ">= 1.12.2"

  # Opens the block that defines which Terraform providers this project requires.
  required_providers {

    # Declares that this project requires the AWS provider.
    aws = {

      # Specifies the official HashiCorp AWS provider from the Terraform Registry.
      source = "hashicorp/aws"

      # Allows AWS provider versions within the 6.x release family.
      # For example, 6.1, 6.20, etc., but not 7.0.
      version = "~> 6.0"
    }
  }
}