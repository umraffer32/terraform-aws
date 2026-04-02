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

resource "aws_instance" "web" {
  #count         = 10
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name    = "AWS"
  subnet_id   = "subnet-0d04810da9f7a1207"
  vpc_security_group_ids = ["sg-00d423d220bf3177d"]
  associate_public_ip_address = true

  tags = {
    #Name = "DIPSHIT-EC2-Instance-${count.index + 1}"
    Name = "Slappin' up the block all night"
  }
}

output "public_ip" {
  value = aws_instance.web[*].public_ip

}

output "instance_names" {
  value = aws_instance.web[*].tags["Name"]

}  