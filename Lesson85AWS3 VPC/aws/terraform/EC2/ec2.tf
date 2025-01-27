provider "aws" {
  region = "us-east-1"
}

# ec2 with apache and ubuntu 24.04
resource "aws_instance" "ubuntu_with_apache" {
  ami           = "ami-0dea0741c00d15478" # ubuntu 24.04 with Apache
  instance_type = "t2.micro"
  tags = {
    Name = "terra-2"
  }
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = "first-instance"

  

}

# resource null_resource "local" {
#   triggers = {
#     always_run = "${timestamp()}"
#   }
#   provisioner "local-exec" {
#     command = "echo ${aws_instance.ubuntu_with_apache.public_ip} > ip_address.txt"
#   }
# }

# elastic ip existing on my aws account
data "aws_eip" "by_allocation_id" {
  id = "eipalloc-0d4b8f9ba7bf858e7"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ubuntu_with_apache.id
  allocation_id = data.aws_eip.by_allocation_id.id
}

#security group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_terra"
  description = "Allow ssh inbound traffic"
 
  ingress {
    description = "SSH_terra"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

   ingress {
    description = "HTTP_terra"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }
}


output "public_ip" {
  value = aws_instance.ubuntu_with_apache.public_ip
}
