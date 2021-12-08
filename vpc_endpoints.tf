# MWAA VPC Endpoints

##
# VPC endpoints required for AWS services
##
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = aws_route_table.private_route_tables.*.id
  policy            = <<POLICY
{
    "Statement": [
        {
            "Action": "s3:GetObject",
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::prod-${var.region}-starport-layer-bucket/*",
            "Principal": "*"
        }
    ]
}
POLICY
  tags = merge(local.tags, {
    Name = "${var.prefix}-s3-endpoint"
  })
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private_subnets.*.id
  security_group_ids  = [aws_security_group.mwaa.id]
  private_dns_enabled = true
  tags = merge(local.tags, {
    Name = "${var.prefix}-ecr-dkr-endpoint"
  })
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private_subnets.*.id
  security_group_ids  = [aws_security_group.mwaa.id]
  private_dns_enabled = true
  tags = merge(local.tags, {
    Name = "${var.prefix}-ecr-api-endpoint"
  })
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private_subnets.*.id
  security_group_ids  = [aws_security_group.mwaa.id]
  private_dns_enabled = true
  tags = merge(local.tags, {
    Name = "${var.prefix}-cloudwatch-logs-endpoint"
  })
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

resource "aws_vpc_endpoint" "cloudwatch_monitoring" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.monitoring"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private_subnets.*.id
  security_group_ids  = [aws_security_group.mwaa.id]
  private_dns_enabled = true
  tags = merge(local.tags, {
    Name = "${var.prefix}-cloudwatch-monitoring-endpoint"
  })
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

resource "aws_vpc_endpoint" "sqs" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.sqs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private_subnets.*.id
  security_group_ids  = [aws_security_group.mwaa.id]
  private_dns_enabled = true
  tags = merge(local.tags, {
    Name = "${var.prefix}-sqs-endpoint"
  })
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

resource "aws_vpc_endpoint" "kms" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.kms"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private_subnets.*.id
  security_group_ids  = [aws_security_group.mwaa.id]
  private_dns_enabled = true
  tags = merge(local.tags, {
    Name = "${var.prefix}-kms-endpoint"
  })
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}


##
# VPC endpoints required for Apache Airflow
##
resource "aws_vpc_endpoint" "airflow_api" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.airflow.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private_subnets.*.id
  security_group_ids  = [aws_security_group.mwaa.id]
  private_dns_enabled = true
  tags = merge(local.tags, {
    Name = "${var.prefix}-airflow-api-endpoint"
  })
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

resource "aws_vpc_endpoint" "airflow_env" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.airflow.env"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private_subnets.*.id
  security_group_ids  = [aws_security_group.mwaa.id]
  private_dns_enabled = true
  tags = merge(local.tags, {
    Name = "${var.prefix}-airflow-env-endpoint"
  })
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

resource "aws_vpc_endpoint" "airflow_ops" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.airflow.ops"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private_subnets.*.id
  security_group_ids  = [aws_security_group.mwaa.id]
  private_dns_enabled = true
  tags = merge(local.tags, {
    Name = "${var.prefix}-airflow-ops-endpoint"
  })
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}