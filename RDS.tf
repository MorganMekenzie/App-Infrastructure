resource "aws_db_subnet_group" "DB_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [data.aws_subnet.data_a.id, data.aws_subnet.data_b.id]

  tags = {
    Name = "Wordpress DB subnet group"
  }
}



# create RDS MySQL DB
resource "aws_db_instance" "main" {
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  db_name              = "wordpress_db"
  username             = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.current.secret_string))["wordpress_username"]
  password             = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.current.secret_string))["wordpress_password"]
  allocated_storage    = 20
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.DB_subnet_group.name

}