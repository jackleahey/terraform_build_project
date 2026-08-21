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