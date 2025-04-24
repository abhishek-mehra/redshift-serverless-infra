data "aws_route_table" "main" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.redshift_vpc.id]
  }

  filter {
    name   = "association.main"
    values = ["true"]
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.redshift_vpc.id
  service_name      = "com.amazonaws.us-east-1.s3"
  route_table_ids   = [data.aws_route_table.main.id]
  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "S3 VPC Endpoint"
  }
}

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id              = aws_vpc.redshift_vpc.id
  service_name        = "com.amazonaws.us-east-1.secretsmanager"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [
    aws_subnet.redshift_subnet_1.id,
    aws_subnet.redshift_subnet_2.id,
    aws_subnet.redshift_subnet_3.id
  ]
  security_group_ids  = [aws_security_group.redshift_sg.id]

  private_dns_enabled = true

  tags = {
    Name = "SecretsManager VPC Endpoint"
  }
}
