resource "aws_iam_role" "step_function_exec" {
  name = "fitbit-step-function-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "states.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "step_function_glue_policy" {
  name = "StepFunctionGluePolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "glue:StartJobRun",
          "glue:GetJobRun",
          "glue:GetJobRuns"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_step_glue_policy" {
  role       = aws_iam_role.step_function_exec.name
  policy_arn = aws_iam_policy.step_function_glue_policy.arn
}

resource "aws_sfn_state_machine" "fitbit_etl_state_machine" {
  name     = "fitbit-etl-pipeline"
  role_arn = aws_iam_role.step_function_exec.arn
  definition = file("${path.module}/step_function_definition.json")

  tags = {
    Purpose = "Fitbit Orchestration"
    Environment = "dev"
  }
}
