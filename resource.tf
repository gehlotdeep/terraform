# --------------------------------------------------
# Key Pair - TLS Private Key
# --------------------------------------------------
resource "tls_private_key" "key_tls" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# --------------------------------------------------
# AWS Key Pair
# --------------------------------------------------
resource "aws_key_pair" "deployer" {
  key_name   = "private"
  public_key = tls_private_key.key_tls.public_key_openssh
}

# --------------------------------------------------
# VPC
# --------------------------------------------------
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = var.my_vpc
  }
}

# --------------------------------------------------
# Public Subnet
# --------------------------------------------------
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# --------------------------------------------------
# Internet Gateway
# --------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

# --------------------------------------------------
# Route Table
# --------------------------------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# --------------------------------------------------
# Route Table Association
# --------------------------------------------------
resource "aws_route_table_association" "public_asso" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# --------------------------------------------------
# Security Group
# --------------------------------------------------
resource "aws_security_group" "my_security_group" {
  name        = var.my_security_group
  description = "Security group for EC2 instance"
  vpc_id      = aws_vpc.my_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = var.my_security_group
  }
}

# --------------------------------------------------
# EC2 Instance
# --------------------------------------------------
resource "aws_instance" "my_instance" {
  ami                         = "ami-03446a3af42c5e74e"
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.my_subnet.id
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.my_security_group.id]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/nginx.sh")

  # Root volume (better than ebs_block_device for root disk)
  root_block_device {
    volume_size = var.env == "prd" ? 16 : var.volume_ebs
    volume_type = "gp3"
  }

  tags = {
    Name = "server"
  }
}

# --------------------------------------------------
# Save Private Key Locally
# --------------------------------------------------
resource "local_file" "private_key" {
  content         = tls_private_key.key_tls.private_key_pem
  filename        = "${path.module}/deployer.pem"
  file_permission = "0400"
}


