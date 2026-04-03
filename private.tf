resource "aws_instance" "private1" {
  count = 10  
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name               = "AWS"
  subnet_id              = "subnet-03d40de794a5cedd6"   # Private Subnet 1  
  vpc_security_group_ids = ["sg-02ef260d2036db821"]     # Private-SG

  tags = {
    Name = "SN1-Private-${count.index + 1}"
  }
}

resource "aws_instance" "private2" {
  count = 10
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name               = "AWS"
  subnet_id              = "subnet-0a7a100eabab08ce2"   # Private Subnet 2  
  vpc_security_group_ids = ["sg-02ef260d2036db821"]     # Private-SG

  tags = {
    Name = "SN2-Private-${count.index + 1}"
  }
}

output "private_sn1" {
  value = {
    for i in aws_instance.private1 :
    i.tags["Name"] => i.private_ip
  }
}

output "private_sn2" {
  value = {
    for i in aws_instance.private2 :
    i.tags["Name"] => i.private_ip
  }
}
