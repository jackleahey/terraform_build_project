#Returns the ID of the VPC created by this module
output "vpc_id" {

  #Return the AWS VPC ID
  value = aws_vpc.main.id

}

output "public_subnet_ids" {

  #Returns all public subnet IDs.
  value = aws_subnet.public[*].id
}

#Returns the IDs of the private subnets
output "private_subnet_ids" {

  #Returns all private subnet IDs.
  value = aws_subnet.private[*].id
}

#Exposes the NAT GAteway ID when NAT exists
output "nat_gateway_id" {

  #Returns the Nat Gateway ID when enabled, otherwise returns NULL
  value = var.enable_nat_gateway ? aws_nat_gateway.main[0].id : null

}

#Exposes the public IP assigned to the NAT Gateway
output "nat_public_ip" {

  #Returns the NAT Elastic IP when enabled, otherwise returns null 
  value = var.enable_nat_gateway ? aws_eip.nat[0].public_ip : null
}

