resource "aws_glue_connection" "redshift_jdbc"{
    name = "redshift-jdbc-conn"

    connection_type = "JDBC"

    connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:redshift://dev-workgroup.104334887604.us-east-1.redshift-serverless.amazonaws.com:5439/dev"
    USERNAME            = var.redshift_username
    PASSWORD            = var.redshift_password
    }
    
    physical_connection_requirements {
    availability_zone      = "us-east-1a" 
    security_group_id_list = [aws_security_group.redshift_sg.id]
    subnet_id              = aws_subnet.redshift_subnet_1.id
  }

  tags = {
    Purpose = "ETL connection to Redshift Serverless"
  }
}
