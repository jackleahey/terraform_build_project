#Looks up the most recent Amazon Linux 2023 AMI published by AWS
data "aws_ami" "amazon_linux" {

  #Selects the most recent AMI that matches the filters below
  most_recent = true

  #Restricts results to AMIs owned by Amazon
  owners = ["amazon"]

  #Filters AMIs by the standard Amazon Linux 2023 x86_64 naming pattern
  filter {

    #filters on the AMI name field
    name = "name"

    #Matches Amazon Linux 2023 x86_64 AMIs
    values = ["al2023-ami-2023*-x86_64"]
  }

  #Filters AMIs to the HVM virtualization type
  filter {

    #Filters on the virtualization type field
    name = "virtualization-type"

    #Requires HVM virtualization
    values = ["HVM"]
  }
}

#Creates the private Linux EC2 instance used for Linux, Anisble, Go and future labs
resource "aws_instance" "linux" {

  #Uses the dynamically discovered Amazon Linux 2023 AMI
  ami = data.aws_ami.amazon_linux.id

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