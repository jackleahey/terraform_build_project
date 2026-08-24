#Creates the IAM role that future EC2 instances will assume
resource "aws_iam_role" "ec2" {

  #Creates a descriptive name for the EC2 IAM role
  name = "${var.project_name}-${var.environment}-ec2-role"

  #Defines which AWS service is allowed to assume this role
  assume_role_policy = jsonencode({

    #Specifies the IAM policy-language version
    Version = "2012-10-17"

    #Defines the trust-policy statements
    Statement = [

      #Defines the trust relationship that allows EC2 to assume this role
      {

        #Allows the action described below
        Effect = "Allow"

        #Identifies EC2 as the trusted AWS service
        Principal = {

          #Allows the EC2 service to assume this IAM role
          Service = "ec2.amazonaws.com"
        }

        #Allows EC2 to obtain temporary credentials for this role
        Action = "sts:AssumeRole"
      }
    ]
  })

  #Applies identifying tags to the IAM role
  tags = {

    #Creates the Name tag for the IAM role
    Name = "${var.project_name}-${var.environment}-ec2-role"
  }
}

#Attaches AWS managed Systems Manager permissions to the EC2 IAM role
resource "aws_iam_role_policy_attachment" "ssm" {

  #Identifies the EC2 IAM role that will receive the permissions
  role = aws_iam_role.ec2.name

  #Attaches the AWS-managed policy required for core Systems Manager functionality
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#Creates the instance profile that allows an EC2 instance to use the IAM role
resource "aws_iam_instance_profile" "ec2" {

  #Creates a descriptive name for the instance profile
  name = "${var.project_name}-${var.environment}-ec2-instance-profile"

  #Associates the EC2 IAM role with this instance profile
  role = aws_iam_role.ec2.name

  #Applies identifying tags to the instance profile
  tags = {

    #Creates the Name tag for the instance profile
    Name = "${var.project_name}-${var.environment}-ec2-instance-profile"
  }
}