resource "aws_glue_job" "fitbit_activity_etl" {
  name     = "fitbit-activity-etl"
  role_arn = aws_iam_role.glue_job_role.arn

  command {
    name            = "glueetl"
    script_location = "s3://redshift-secure-data-lake-104334887604/scripts/process_all_activities_glue_job.py"
    python_version  = "3"                      # Glue 5 supports Python 3.10
  }

  glue_version       = "5.0"                   # 🔄 Use Glue version 5.0 (latest as of 2024–2025)
  number_of_workers  = 2
  worker_type        = "G.1X"
  timeout            = 10
  max_retries        = 0

  default_arguments = {
    "--job-language"         = "python"
    "--TempDir"              = "s3://redshift-secure-data-lake-104334887604/glue-temp/"
    "--enable-glue-datacatalog" = "true"       # ✅ Recommended for v5
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-spark-ui"      = "true"          # Optional but helpful for debugging
    "--spark-event-logs-path" = "s3://redshift-secure-data-lake-104334887604/spark-events/"
  }

  tags = {
    Environment = "prod"
    Project     = "FitbitPipeline"
  }
}

resource "aws_cloudwatch_log_group" "glue_logs" {
  name              = "/aws-glue/jobs/output"
  retention_in_days = 7
}
