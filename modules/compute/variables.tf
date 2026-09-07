#Defines the project name used when naming and tagging compute resources.
variable "project_name" {

  #Describes the purpose of this variable
  description = "Project name used for compute resource naming and tagging"

  #Requires the project name to be provided as a string
  type = string
}

#Defines the deployment environment, such as dev, stage or prod 
variable "environment" {

  #Describes the purpose of this variable
  description = "Deployment environment name"

  #Requires the environment name to be provided as a string
  type = string
}

#Defines the subnet where the EC2 instance will be created
variable "subnet_id" {

  #Describes the purpose of this variable
  description = "Subnet ID where the EC2 instance will be deployed"

  #Requires the subnet ID to be provided as a string
  type = string
}

#Defines the security group attached to the EC2 instance
variable "security_group_id" {

  # Describes the purpose of this variable.
  description = "Security group ID attached to the EC2 instance"

  # Requires the security group ID to be provided as a string.
  type = string
}


# Defines the IAM instance profile attached to the EC2 instance.
variable "instance_profile_name" {

  # Describes the purpose of this variable.
  description = "IAM instance profile name attached to the EC2 instance"

  # Requires the instance profile name to be provided as a string.
  type = string
}


# Defines the EC2 instance type used by the Linux server.
variable "instance_type" {

  # Describes the purpose of this variable.
  description = "EC2 instance type used by the Linux development server"

  # Requires the instance type to be provided as a string.
  type = string

  # Uses a small instance type by default for cost control.
  default = "t3.micro"
}