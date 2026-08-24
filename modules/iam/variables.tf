#Defines the project name used when naming and tagging IAM resources
variable "project_name" {

  #Explains the purpose of this variable
  description = "Project name used for IAM resource naming and tagging"

  #Requires the project name to be supplied as a string
  type = string
}

#Defines the deployment environment, such as dev, stage or prod
variable "environment" {

  #Explains the purpose of this variable
  description = "Deployment environment name"

  #Requires the environment name to be supplied as a string
  type = string
}