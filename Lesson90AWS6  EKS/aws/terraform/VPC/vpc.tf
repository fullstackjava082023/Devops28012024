provider "aws" {
    region = "us-east-1"
}

resource "aws_subnet" "main" {
  vpc_id     = "vpc-095cd15c99baabd30"
  cidr_block = "172.31.201.0/24"

  tags = {
    Name = "terra-subnet"
  }
}


# module "ec2" {
#     source = "../EC2"  
#     # required variable
#     instance_type = "t2.micro"
# }

# module "ssh_security_group" {
#   source  = "terraform-aws-modules/security-group/aws//modules/ssh"
#   version = "~> 5.0"

#   name = "allow_ssh_module"
#   vpc_id = "vpc-095cd15c99baabd30"
# }

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    name = "my-demo-vpc-terra"
    cidr = "10.10.0.0/16"
    azs             = ["us-east-1a", "us-east-1b"]
    private_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
    public_subnets  = ["10.10.101.0/24", "10.10.102.0/24"]
    enable_nat_gateway = true
    single_nat_gateway = true
    enable_vpn_gateway = true
}
