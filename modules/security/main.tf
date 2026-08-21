#Creates the security group that will be attached to development EC2 instances
resource "aws_security_group" "ec2" {

  #Creates a descriptive name for the security group
  name = "${var.project_name}-${var.environment}-ec2-sg"

  #Describes what this security group protects
  description = "Security group for the private EC2 instances"

  #Creates the security group inside the VPC supplied by the parent module
  vpc_id = var.vpc_id

  #Applies identifying tags to the security group
  tags = {

    #Creates the Name tag shown int he AWS console
    Name = "${var.project_name}-${var.environment}-ec2-sg"
  }
}

#Allows the EC2 security group to initiate outbound IPv4 connections
resource "aws_vpc_security_group_egress_rule" "ec2_all_ipv4" {

  #Attaches this outbound rule to the EC2 security group
  security_group_id = aws_security_group.ec2.id

  #Allows traffic to any IPv4 destination
  cidr_ipv4 = "0.0.0.0/0"

  #Allows every IP protocol
  ip_protocol = "-1"

  #Documents the purpose of this security group rule
  description = "Allow outbound IPv4 traffic"
}