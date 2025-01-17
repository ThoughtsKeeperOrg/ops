resource "aws_db_instance" "postgres_ltm_instance" {
  allocated_storage   = 5
  storage_type        = "standard"
  engine              = "postgres"
  engine_version      = "14"
  instance_class      = "db.t3.micro"
  db_name             = var.DB_NAME
  username            = var.DB_USERNAME
  password            = var.DB_PASSWORD
  skip_final_snapshot = true
  availability_zone   = "us-west-2a"
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.postgres_ltm_group.id]
}


resource "aws_security_group" "postgres_ltm_group" {
  name = "postgres_ltm_group"

  ingress {
    from_port   = "5432"
    to_port     = "5432"
    protocol    = "tcp"
    description = "PostgreSQL"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = "5432"
    to_port          = "5432"
    protocol         = "tcp"
    description      = "PostgreSQL"
    ipv6_cidr_blocks = ["::/0"]
  }
}
