resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t3.micro"
  name                 = "database-1"
  username             = "admin"
  password             = "RmGgpHhnts4EOWWqibcg"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}