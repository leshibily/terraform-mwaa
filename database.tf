## RDS Oracle Database
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.prefix}-db-subnet-group"
  description = "${var.prefix} database subnet group"
  subnet_ids  = aws_subnet.public_subnets.*.id
  tags = merge(local.tags, {
    Name = "${var.prefix}-db-subnet-group"
  })
}

resource "aws_security_group" "db_security_group" {
  name        = "${var.prefix}-oracle-db-sg"
  description = "Allow Oracle port to public"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow Oracle DB Port"
    from_port   = 1521
    to_port     = 1521
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "${var.prefix}-orable-db-sg"
  })
}

resource "aws_db_instance" "db_instance" {
  identifier             = "${var.prefix}-oracle-${random_id.id.hex}"
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  license_model          = var.db_license_model
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  port                   = var.db_port
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot    = true
  publicly_accessible    = true
  tags = merge(local.tags, {
    Name = "${var.prefix}-oracle-${random_id.id.hex}"
  })
}



