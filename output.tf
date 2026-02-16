output "public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "instance_id" {
  value = aws_instance.my_instance.id
}

output "aws_vpc" {
  value = aws_vpc.my_vpc.id
}

output "ami" {
  value = aws_instance.my_instance.ami

}
