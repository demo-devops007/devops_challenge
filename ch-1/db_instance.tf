#Create Database instance
/*
resource "aws_db_instance" "default" {
  allocated_storage      = 2
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = "mysql"
  engine_version         = var.db_version
  instance_class         = var.db_instance_class
  multi_az               = false
  name                   = "mydb"
  username               = "sqluser"
  password               = "${file("../mysql_pass.txt")}"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.database-sg.id]
}

*/