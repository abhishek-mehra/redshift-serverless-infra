resource "aws_redshiftserverless_namespace" "main" {
  namespace_name = "dev-namespace"
  kms_key_id     = aws_kms_key.redshift_kms.arn

  tags = {
    Environment = "dev"
  }
}

resource "aws_redshiftserverless_workgroup" "main" {
  workgroup_name = "dev-workgroup"
  namespace_name = aws_redshiftserverless_namespace.main.namespace_name

  subnet_ids = [
    aws_subnet.redshift_subnet_1.id,
    aws_subnet.redshift_subnet_2.id,
    aws_subnet.redshift_subnet_3.id
  ]

  security_group_ids = [aws_security_group.redshift_sg.id]

  tags = {
    Environment = "dev"
  }
}
