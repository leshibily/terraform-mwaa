# MWAA network

data "aws_availability_zones" "availability_zones" {
  state = "available"
}

resource "aws_route_table" "private_route_tables" {
  count  = length(var.private_subnet_ids)
  vpc_id = var.vpc_id

  tags = merge(local.tags, {
    Name = format("${var.prefix}-private%02d", count.index + 1)
  })
}

resource "aws_route_table_association" "private_route_table_associations" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private_route_tables[count.index].id
}

resource "aws_security_group" "mwaa" {
  name        = "${var.prefix}-security-group"
  description = "Security Group for Amazon MWAA Environment"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "${var.prefix}-security-group"
  })
}
