#Defines the project name used for naming and tagging AWS resources
variable "project_name" {

  #Describes the purpose of this variable
  description = "Name of the project used for resource naming and tags"

  #Requires the value to be a string
  type = string
}

#Defines the deployment environment, such as dev, stage, or prod.
variable "environment" {

  #Describes the purpose of this variable
  description = "Deployment environment name"

  #Requires the value to be a string.
  type = string
}

#Defines the CIDR block
variable "vpc_cidr" {

  #Describes the purpose of this variable.
  description = "CIDR block for the VPC"

  #Requires the CIDR value to be supplied as a string
  type = string
}

#Defines the CIDR blocks for public subnets
variable "public_subnet_cidrs" {

  #Describes the purpose of this variable.
  description = "CIDR blocks for the public subnets"

  #Requires a list containing string values
  type = list(string)
}

#Defines the CIDR blocks for private subnets
variable "private_subnet_cidrs" {

  #Describes the purpose of this variable.
  description = "CIDR blocks for the private subnets"

  #Requires a list containing string values
  type = list(string)
}

#Defines the AWS Availability Zones where subnets will be created
variable "availability_zones" {

  # Describes the purpose of this variable.
  description = "Availability Zones used by the networking module"

  # Requires a list containing Availability Zone names as strings.
  type = list(string)
}

#Controls whether the networking module creates a NAT Gateway
variable "enable_nat_gateway" {

  #Describes the purpose of this variable
  description = "Determines whether a NAT Gateway should be created"

  #Requires the value to either be true or false
  type = bool

  #Keeps the NAT Gateway disabled unless an environment explicitly enables it
  default = false
}