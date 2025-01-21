provider "aws" {
  region = "us-east-1"  
}


resource "aws_instance" "example" {
  ami           = "ami-0dea0741c00d15478" # ubuntu 24.04 with Apache
  instance_type = "t2.micro"
  tags = {
    Name = "terra-1"
  }
#    = ["sg-0f80918d307780b5a"]
    vpc_security_group_ids = ["sg-0f80918d307780b5a"]

    key_name = "first-instance"
}



output "public_ip" {
  value = aws_instance.example.public_ip
}