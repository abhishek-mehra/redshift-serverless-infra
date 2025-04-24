resource "aws_iam_policy" "glue_connection_access" {
  name = "GlueConnectionAccessPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "glue:GetConnection",
          "glue:GetConnections"
        ],
        Resource = [
          "arn:aws:glue:us-east-1:${data.aws_caller_identity.current.account_id}:catalog",
          "arn:aws:glue:us-east-1:${data.aws_caller_identity.current.account_id}:connection/redshift-jdbc-conn"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_glue_connection_policy" {
  role       = aws_iam_role.glue_job_role.name
  policy_arn = aws_iam_policy.glue_connection_access.arn
}
