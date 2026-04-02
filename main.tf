terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "bastion" {
  # count         = 1
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name    = "AWS"
  subnet_id   = "subnet-0d04810da9f7a1207"             # Public Subnet
  vpc_security_group_ids = ["sg-00d423d220bf3177d"]    # Bastion-SG
  associate_public_ip_address = true

  tags = {
    # Name = "serv0-${count.index + 1}"
    Name = "Bastion"
  }
}

resource "aws_instance" "nat" {
  # count         = 1
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name    = "AWS"
  subnet_id   = "subnet-0d04810da9f7a1207"             # Public Subnet
  vpc_security_group_ids = ["sg-0f8f7418b9bf85183"]    # NAT-SG
  associate_public_ip_address = true
  source_dest_check = false

  tags = {
    # Name = "serv0-${count.index + 1}"
    Name = "NAT"
  }
}

output "instances" {
  value = {
    bastion = {
      name = aws_instance.bastion.tags["Name"]
      ip   = aws_instance.bastion.public_ip
    }
    nat = {
      name = aws_instance.nat.tags["Name"]
      ip   = aws_instance.nat.public_ip
    }

  }
}

# output "instances" {
#   value = {
#     for i in try(aws_instance.bastion, [aws_instance.bastion]) :
#     i.tags["Name"] => i.public_ip
#   }
# }
