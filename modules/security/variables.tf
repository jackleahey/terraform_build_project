#Defines the project name used when naming and tagging security resources
variable "project_name" {

  #Describes the purpose of this variable
  description = "Project name used for security resource naming and tagging"

  #Requires the project name to be provided as a string
  type = string
}

#Defines the environment name, such as dev, stage, or prod 
variable "environment" {

  #Describes the purpose of this variable
  description = "Deployment environment name"

  #Requires the environment name to be provided as a string
  type = string
}

#Defines the VPC where the security resources will be created
variable "vpc_id" {

  #Describes the purpose of this variable.
  description = "ID of the VPC where security resources will be created"

  #Requires the VPC ID to be provided as a string.
  type = string
}