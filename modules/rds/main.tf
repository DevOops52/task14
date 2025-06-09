resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Security group for RDS"
  vpc_id      = var.vpc_id
  tags        = { Name = "rds-sg" }
}

resource "aws_vpc_security_group_ingress_rule" "allow_postgres_ipv4" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_rds_ipv4" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags       = { Name = "rds-subnet-group" }
}

resource "aws_db_instance" "rds" {
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "mydb"
  username               = "postgres"
  password               = "Aboba228"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  monitoring_interval    = 0
  publicly_accessible    = false
  tags                   = { Name = "task11-rds" }
}
