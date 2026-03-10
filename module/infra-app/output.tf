output "public_ip"{
  value       = aws_instance.my_instance[*].public_ip
}

output "aws_vpc"{
  value	      = aws_vpc.my_vpc.id
}
