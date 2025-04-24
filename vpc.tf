resource "aws_vpc" "redshift_vpc"{
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags = {
        Name = "redshift-vpc"
    }
}

resource "aws_subnet" "redshift_subnet_1" {
    vpc_id            = aws_vpc.redshift_vpc.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "redshift-subnet-1"
    }
}

resource "aws_subnet" "redshift_subnet_2" {
    vpc_id            = aws_vpc.redshift_vpc.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "redshift-subnet-2"
    }
}

resource "aws_subnet" "redshift_subnet_3" {
    vpc_id            = aws_vpc.redshift_vpc.id
    cidr_block        = "10.0.3.0/24"
    availability_zone = "us-east-1c"

    tags = {
        Name = "redshift-subnet-3"
    }
}

resource "aws_security_group" "redshift_sg"{
    name = "redshift-security-group"
    description = "allow redshift access within VPC"
    vpc_id = aws_vpc.redshift_vpc.id

    ingress{
        from_port = 5439
        to_port = 5439
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }

    # Glue job worker communication
    ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
    }
    
    egress{
        from_port = 0 
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}


