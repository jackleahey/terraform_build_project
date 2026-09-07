#Exposes the EC2 instance ID to the parent module
output "instance_id" {

  #Returns the ID assigned to the Linux EC2 instance
  value = aws_instance.linux.id
}

#Exposes the private IPv4 address of the Linux EC2 instance
output "private_ip" {

  #Returns the private IP assigned to the Linux EC2 instance
  value = aws_instance.linux.private_ip
}

#Exposes the AMU ID used to create the Linux EC2 instance
output "ami_id" {

  #Returns the dynamically selected Amazon Linux AMI ID
  value = data.aws_ami.amazon_linux.id
}