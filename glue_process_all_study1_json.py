resource "aws_glue_job" "study1_etl" {
  name     = "study1-etl"
  role_arn = aws_iam_role.glue_job_role.arn

  command {
    name            = "glueetl"
    script_location = "s3://redshift-secure-data-lake-104334887604/scripts/study1/process_all_study1_json.py"
    python_version  = "3"
  }

  glue_version      = "5.0"
  number_of_workers = 2
  worker_type       = "G.1X"
  timeout           = 10
  max_retries       = 0

  default_arguments = {
    "--job-language" = "python"
    "--study_name"   = "study1"
    "--TempDir"      = "s3://redshift-secure-data-lake-104334887604/glue-temp/"
    "--enable-glue-datacatalog" = "true"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-spark-ui" = "false"
    "--spark-event-logs-path" = "s3://redshift-secure-data-lake-104334887604/spark-events/"
  }

  tags = {
    Environment = "prod"
    Project     = "Study1Pipeline"
  }
}
