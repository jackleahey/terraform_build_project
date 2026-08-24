#Exposes the name of the EC2 IAM role to the parent module
output "ec1_role_name" {

  #Returns the generated IAm role name
  value = aws_iam_role.ec2.name
}

#Exposes the ARN of the EC2 IAM role to the parent module
output "ec2_role_arn" {

  #Returns the generated IAM role ARN
  value = aws_iam_role.ec2.arn
}

#Exposes the EC2 instance profile name to the parent module
output "ec2_instance_profile_name" {

  #Returns the generated instance profile name
  value = aws_iam_instance_profile.ec2.name
}