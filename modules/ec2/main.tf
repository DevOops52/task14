resource "aws_security_group" "bastion_sg" {
  name        = "${var.sg_name}-bastion"
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id
  tags = { Name = "${var.sg_name}-bastion-sg" }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_bastion_ipv4" {
  for_each          = { for idx, rule in var.allowed_ssh_ips : idx => rule }
  security_group_id = aws_security_group.bastion_sg.id
  cidr_ipv4         = each.value.ip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_bastion_ipv4" {
  security_group_id = aws_security_group.bastion_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "private_sg" {
  name        = "${var.sg_name}-private"
  description = "Security group for private server"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.sg_name}-private-sg" }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_bastion" {
  security_group_id            = aws_security_group.private_sg.id
  referenced_security_group_id = aws_security_group.bastion_sg.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_private_ipv4" {
  security_group_id = aws_security_group.private_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "bastion" {
  ami             = "ami-084568db4383264d4"
  instance_type   = "t2.nano"
  subnet_id       = var.public_subnet_id
  security_groups = [aws_security_group.bastion_sg.id]
  key_name        = var.key_name
  tags            = { Name = "bastion-host" }
}

resource "aws_instance" "private" {
  ami             = "ami-084568db4383264d4"
  instance_type   = "t2.nano"
  subnet_id       = var.private_subnet_id
  security_groups = [aws_security_group.private_sg.id]
  key_name        = var.key_name
  tags            = { Name = "private-server" }
}
