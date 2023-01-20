# Security Group
resource "aws_security_group" "db" {
  name_prefix = var.db_security_group_name
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "DB from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.db_security_group_name
  }
}

# DB Subnet group
resource "aws_db_subnet_group" "tf-db" {
  name       = "db-subnet_group"
  subnet_ids = [aws_subnet.pri_a.id, aws_subnet.pri_c.id]

  tags = {
    Name = "Terraform DB subnet group"
  }
}

# DB instanace
resource "aws_db_instance" "tf-db" {
  identifier_prefix      = "tf-db"
  allocated_storage      = 10
  db_name                = "tf_db"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  multi_az               = true
  username               = "smj"
  password               = "password"
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.lab-db.name
  vpc_security_group_ids = [aws_security_group.db.id]
}