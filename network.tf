# MWAA network

data "aws_availability_zones" "availability_zones" {
  state = "available"
}

resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.availability_zones.names[count.index]
  map_public_ip_on_launch = false

  tags = merge(local.tags, {
    Name = format("${var.prefix}-private%02d", count.index + 1)
  })
}

resource "aws_route_table" "private_route_tables" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = var.vpc_id

  tags = merge(local.tags, {
    Name = format("${var.prefix}-private%02d", count.index + 1)
  })
}

resource "aws_route_table_association" "private_route_table_associations" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private_subnets[count.index].id
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
