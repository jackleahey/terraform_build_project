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

#Calls the reusable IAM module for the development environment
module "iam" {

  #Specifies the relative location of the IAM child module
  source = "../../modules/iam"

  #Passes the project name from the DEV into the IAM module
  project_name = var.project_name

  #Passes the environment name from DEV into the IAM module
  environment = var.environment
}

#Calls the reusable compute module for the development environment
module "compute" {

  #Specifies the relative location of the compute child module
  source = "../../modules/compute"

  #Passes the project name from the development environment into the compute module
  project_name = var.project_name

  #Passes the development environment name into the compute module
  environment = var.environment

  #Places the Linux instance into the first private subnet created by the networking module
  subnet_id = module.networking.private_subnet_ids[0]

  #Attaches the EC2 security group created by the security module
  security_group_id = module.security.ec2_security_group_id

  #Attaches the EC2 IAM instance profile created by the IAM module
  instance_profile_name = module.iam.ec2_instance_profile_name

  #Uses a small EC2 instance type for the development lab
  instance_type = "t3.micro"
}