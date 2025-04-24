resource "aws_glue_job" "copy_parquet_to_redshift"{
    name = "copy-parquet-to-redshift"
    role_arn = aws_iam_role.glue_job_role.arn
    glue_version = "5.0"
    number_of_workers = 2
    worker_type = "G.1X"

    command{
        name = "glueetl"
        script_location = "s3://redshift-secure-data-lake-104334887604/scripts/copy_all_to_redshift.py"
        python_version = "3"
    }

      default_arguments = {
    "--job-language" = "python"
    "--TempDir" = "s3://redshift-secure-data-lake-104334887604/temp/"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-glue-datacatalog" = "true"
    "--enable-metrics" = "true"
    "--JOB_NAME" = "copy-parquet-to-redshift"

    }
    connections = [aws_glue_connection.redshift_jdbc.name]

    tags = {
    Purpose = "Load Parquet into Redshift"
    Environment = "dev"
  }

}

# Policy to allow Glue to read from Secrets Manager
resource "aws_iam_policy" "glue_secrets_policy" {
  name = "GlueSecretsReadPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = "arn:aws:secretsmanager:us-east-1:${data.aws_caller_identity.current.account_id}:secret:redshift/glue/credentials*"
      }
    ]
  })
}

# Attach the policy to Glue job role
resource "aws_iam_role_policy_attachment" "attach_glue_secrets" {
  role       = aws_iam_role.glue_job_role.name
  policy_arn = aws_iam_policy.glue_secrets_policy.arn
}
