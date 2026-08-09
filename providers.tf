# Configures the AWS provider that was declared as a requirement in versions.tf.
provider "aws" {

  # Tells the AWS provider which AWS Region should be used for resources and API requests.
  region = "us-east-1"
}