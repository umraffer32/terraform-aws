resource "aws_instance" "bastion" {
  tags = {
    Name = "Bastion"
    Role = "bastion"
  }

  # ami                         = data.aws_ami.ubuntu.id
  ami                         = data.aws_ami.debian.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name
}

resource "aws_instance" "nat" {
  tags = {
    Name = "NAT"
    Role = "nat"
  }

  # ami                         = data.aws_ami.ubuntu.id
  ami                         = data.aws_ami.debian.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.nat_sg.id]
  associate_public_ip_address = true
  source_dest_check           = false
  key_name                    = var.key_name
}

resource "aws_instance" "private_1" {
  count = var.private_1_count

  tags = {
    Name = "SN1-Private-${count.index + 1}"
    Role = "private"
  }

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_1.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = var.key_name
}

resource "aws_instance" "private_2" {
  count = var.private_2_count

  tags = {
    Name = "SN2-Private-${count.index + 1}"
    Role = "private"
  }

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_2.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = var.key_name
}

