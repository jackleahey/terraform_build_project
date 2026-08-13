#Defines the AWS Region where the development environment will be deployed
variable "aws_region" {

    #Describes the variables purpose
    description = "AWS Region used for the development environment"

    #Requires the value to be a string
    type = string

    #Uses us-east-1 unless another region is explicitly provided
    default = "us-east-1"
}

#Defines the project name used when naming and tagging development resources
variable "project_name" {

    description = "Project name used for resource naming and tagging"

    type = string

    default = "terraform-build-project"
}

#Defines the name of this deployment environment
variable "environment" {

    description = "Deployment environment name"

    type = string

    default = "dev"
}

#Defines the CIDR block assigned to the devlopment VPC
variable "vpc_cidr" {

    description = "CIDR block for the development VPC"

    type = string

    #Assigns a /16 private address range to the development VPC
    default = "10.0.0.0/16"
}

#Defines the CIDR blocks assigned to the development public subnets
variable "public_subnet_cidrs" {

    description = "CIDR blocks for the deployment of public subnets"

    #Requires a list containing string values
    type = list(string)

    #Creates two public subnet address ranges.
    default = [
        "10.0.1.0/24",
        "10.0.2.0/24"
    ]
}

#Defines the CIDR blocks assigned to the development private subnets
variable "private_subnet_cidrs" {

    description = "CIDR blocks for the deployment of private subnets"

    #Requires a list containing string values
    type = list(string)

    #Creates two public subnet address ranges.
    default = [
        "10.0.11.0/24",
        "10.0.12.0/24"
    ]
}

#Defines the Availability Zones used by the development network
variable "availability_zones" {

    description = "Availability Zones used by the deployment environment"

    #Requires a list containing Availability Zone names
    type = list(string)

    #Spreads the development network across two Availability Zones
    default = [
        "us-east-1a",
        "us-east-1b"
    ]
}

#Controls whether the deployment environment creates a NAT Gateway
variable "enable_nat_gateway" {

    description = "Determines whether the deployment environment creates a NAT Gateway"

    #Requires the value to be true or false
    type = bool

    #Keeps the NAT Gateway disabled by default to avoid unnecessary AWS charges
    default = false
}