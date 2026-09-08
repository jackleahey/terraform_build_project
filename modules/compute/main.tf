# Retrieves the latest Amazon Linux 2023 x86_64 AMI ID from AWS Systems Manager public parameters.
data "aws_ssm_parameter" "amazon_linux_ami" {

  # Uses the AWS-maintained parameter that points to the
  # latest standard Amazon Linux 2023 x86_64 AMI.
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

#Creates the private Linux EC2 instance used for Linux, Anisble, Go and future labs
resource "aws_instance" "linux" {

  # Uses the latest Amazon Linux 2023 AMI ID returned by the AWS-maintained SSM public parameter.
  ami = data.aws_ssm_parameter.amazon_linux_ami.value

  #Uses the instance type supplied to this module
  instance_type = var.instance_type

  #Places the instance into the private subnet supplied by the parent module
  subnet_id = var.subnet_id

  #Attaches the existing EC2 security group
  vpc_security_group_ids = [var.security_group_id]

  #Attaches IAM instance profile that provides SSM permissions
  iam_instance_profile = var.instance_profile_name

  #Prevents Terraform from assigning a public IPv4 address to this instance
  associate_public_ip_address = false

  #Configures the root EBS volume attached to this instance
  root_block_device {

    #Uses a small root volume to keep storage costs low
    volume_size = 8

    #Uses the general purpose gp3 EBS volume type
    volume_type = "gp3"

    #Encrypts the root EBS volume
    encrypted = true

    #Deletes the root volume automatically if the EC2 instance is destroyed
    delete_on_termination = true
  }

  #Applies identifying tags to the EC2 instance
  tags = {

    #Creates the Name tag displayed in the AWS console
    Name = "${var.project_name}-${var.environment}-linux-server"
  }
}