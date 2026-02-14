resource "aws_instance" "my_new_instance"{
  ami           = "ami-03446a3af42c5e74e"
  instance_type = "t3.micro"
  

  ebs_block_device{
  	device_name = "/dev/sda1"
	volume_size	= "16"
  	volume_type	= "gp3"
}
  tags = {
    Name = "server"
  }
}
