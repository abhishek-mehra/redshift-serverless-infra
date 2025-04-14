variable "aws_region" {
    default = "us-east-1"
}

variable "redshift_admin_password" {
  description = "Password for Redshift admin DB user"
  sensitive   = true
}
