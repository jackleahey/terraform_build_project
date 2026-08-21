#Calls the reusable networking module for the development environment
module "networking" {
  #Tells Terraform where the networking module is located relative to the dev directory
  source = "../../modules/networking"

  # Passes the project name from the dev environment into the networking module.
  project_name = var.project_name

  # Passes the environment name into the networking module.
  environment = var.environment

  #Passes the VPC CIDR block into the networking module
  vpc_cidr = var.vpc_cidr

  #Passes the list of public subnet CIDR blocks into the networking module
  public_subnet_cidrs = var.public_subnet_cidrs

  #Passes the lis of private subnet CIDR blocks into the networking module
  private_subnet_cidrs = var.private_subnet_cidrs

  #Passes the list of Availability Zones into the networking module
  availability_zones = var.availability_zones

  #Passes the NAT Gateway enable/disable setting into the networking module
  enable_nat_gateway = var.enable_nat_gateway
}

#Calls the reusable security module for the development environment
module "security" {

  #Specifies the relative location of the security child module
  source = "../../modules/security"

  #Passes the development project name into the security module
  project_name = var.project_name

  #Passes the development environment name into the security module
  environment = var.environment

  #Passes the VPC ID created by the networking module into the security module
  vpc_id = module.networking.vpc_id
}