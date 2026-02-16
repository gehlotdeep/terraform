# -----------------------------
# EC2 Instance
# -----------------------------
resource "aws_instance" "my_instance" {
  ami           = "ami-03446a3af42c5e74e"
  instance_type = var.instance_type
  user_data	= file("nginx.sh")
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = var.env == "prd" ? 16 : var.volume_ebs
    volume_type = "gp3"
  }

  tags = {
    Name = "server"
  }
}

# -----------------------------
# Create VPC
# -----------------------------
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = var.my_vpc
  }
}

# -----------------------------
# Create Security Group
# -----------------------------
resource "aws_security_group" "my_security_group" {
  vpc_id      = aws_vpc.my_vpc.id
  name        = var.my_security_group
  description = "This is my security group description"

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

  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = ""
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = var.my_security_group
  }
}



