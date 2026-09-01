#Creates the virtual private cloud that will contain all AWS networking resources
resource "aws_vpc" "main" {

  #Assigns the CIDR block passed from the parent modules
  cidr_block = var.vpc_cidr

  #Enables internal DNS resolution within the VPC
  enable_dns_support = true

  #Enables DNS hostnames for resources inside the VPC
  enable_dns_hostnames = true

  #Applies common tags to identify this VPC
  tags = {
    #Creates a Name tag using the project and environment values
    Name = "${var.project_name}-${var.environment}-vpc"
  }
}

#Creates public subnets inside the VPC
resource "aws_subnet" "public" {

  #Creates one subnet for each CIDR provided
  count = length(var.public_subnet_cidrs)

  #Places the subnet inside the VPC we created above
  vpc_id = aws_vpc.main.id

  #Assigns the subnet CIDR block from the variable list
  cidr_block = var.public_subnet_cidrs[count.index]

  #Places each subnet into a different Availability Zone
  availability_zone = var.availability_zones[count.index]

  #Automatically assigns public IPv4 addresses to instances launched here
  map_public_ip_on_launch = true

  #Adds idenifying tags
  tags = {

    #Names each subnet dynamically
    Name = "${var.project_name}-${var.environment}-public-subnet-${count.index + 1}"
  }
}

# Creates private subnets inside the VPC.
resource "aws_subnet" "private" {

  # Creates one subnet for each private CIDR provided.
  count = length(var.private_subnet_cidrs)

  # Places the subnet inside the VPC.
  vpc_id = aws_vpc.main.id

  # Assigns the private subnet CIDR block.
  cidr_block = var.private_subnet_cidrs[count.index]

  # Places each subnet into its Availability Zone.
  availability_zone = var.availability_zones[count.index]

  # Prevents automatic public IP assignment.
  map_public_ip_on_launch = false

  # Adds identifying tags.
  tags = {

    # Names the private subnet.
    Name = "${var.project_name}-${var.environment}-private-subnet-${count.index + 1}"

  }
}

#Creates an Internet Gateway for public subnet internet access
resource "aws_internet_gateway" "main" {

  #Attaches the Internet Gateway to our VPC
  vpc_id = aws_vpc.main.id

  #Adds identifying tags
  tags = {

    #Names the internet Gateway
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

#Creates the route table used by public subnets
resource "aws_route_table" "public" {

  #Places the route table inside our VPC
  vpc_id = aws_vpc.main.id

  #Adds identifying tags
  tags = {

    #Names the public route table
    Name = "${var.project_name}-${var.environment}-public-route-table"
  }
}

#Creates the default route to the internet
resource "aws_route" "public_internet" {

  #Uses the public route table
  route_table_id = aws_route_table.public.id

  #Sends all non-local traffic toward the internet.
  destination_cidr_block = "0.0.0.0/0"

  #Uses the Internet Gateway as the destination.
  gateway_id = aws_internet_gateway.main.id
}

#Associates each public subnet with the public route table
resource "aws_route_table_association" "public" {

  #Creates an association for each public subnet
  count = length(var.public_subnet_cidrs)

  #Selects the subnet being associated
  subnet_id = aws_subnet.public[count.index].id

  #Uses the public route table
  route_table_id = aws_route_table.public.id
}

# Creates the route table used by private subnets.
resource "aws_route_table" "private" {

  # Places the route table inside our VPC.
  vpc_id = aws_vpc.main.id

  # Adds identifying tags.
  tags = {

    # Names the private route table.
    Name = "${var.project_name}-${var.environment}-private-route-table"

  }
}

# Associates each private subnet with the private route table.
resource "aws_route_table_association" "private" {

  # Creates an association for each private subnet.
  count = length(var.private_subnet_cidrs)

  # Selects the subnet being associated.
  subnet_id = aws_subnet.private[count.index].id

  # Uses the private route table.
  route_table_id = aws_route_table.private.id
}

#Creates an Elastic IP only when the NAT Gateway feature is enabled
resource "aws_eip" "nat" {

  #Creates one Elastic IP when NAT is enabled and non when the NAT is disabled
  count = var.enable_nat_gateway ? 1 : 0

  #Declares that this Elastic IP is intended for VPC use 
  domain = "vpc"

  #Applies identifying tags to the Elastic IP
  tags = {

    #Creates a descriptive Name tag for the NAT Elastic IP
    Name = "${var.project_name}-${var.environment}-nat-eip"
  }
}

#Creates a NAT Gateway only when the NAT feature is enabled
resource "aws_nat_gateway" "main" {

  #Creates one NAT Gateway when NAT is enabled and none when NAT is disabled
  count = var.enable_nat_gateway ? 1 : 0

  #Associates the NAT Gateway with the Elastic IP created above.
  allocation_id = aws_eip.nat[0].id

  #Places the NAT Gateway in the first public subnet
  subnet_id = aws_subnet.public[0].id

  #Ensures the Internet Gateway exists before Terraform creates the NAT Gateway
  depends_on = [aws_internet_gateway.main]

  #APplies identifying tags to the NAT Gateway.
  tags = {

    #Creates the Name tag displayed in AWS.
    Name = "${var.project_name}-${var.environment}-nat-gateway"
  }
}

resource "aws_route" "private_nat" {

  #Creates the route only when NAT is enabled
  count = var.enable_nat_gateway ? 1 : 0

  #Adds the route to the private route table
  route_table_id = aws_route_table.private.id

  #Sends all non-local IPv4 traffic toward the NAT Gateway 
  destination_cidr_block = "0.0.0.0/0"

  #Uses the NAT Gateway as the route target
  nat_gateway_id = aws_nat_gateway.main[0].id
}