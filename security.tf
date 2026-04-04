resource "aws_security_group" "bastion_sg" {
  tags = {
    Name = "bastion-sg"
  }

  name        = "bastion-sg"
  description = "Allow SSH to bastion"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from admin IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_sg" {
  tags = {
    Name = "private-sg"
  }

  name        = "private-sg"
  description = "Allow SSH from bastion to private instances"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "SSH from bastion SG"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "nat_sg" {
  tags = {
    Name = "nat-sg"
  }

  name        = "nat-sg"
  description = "Allow private subnet traffic to NAT"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow SSH from Main PC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  ingress {
    description = "All traffic from private subnet 1"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.2.0/24"]
  }

  ingress {
    description = "All traffic from private subnet 2"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.3.0/24"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

