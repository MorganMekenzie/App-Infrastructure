# create RDS MySQL DB
    resource "aws_db_instance" "main" {
        engine = "mysql"
        engine_version = "8.0"
        instance_class = "db.t2.micro"
        name = "my_db"
        username = "testdb01"
        password = "testdatabase1" # use vault to secure your password
        allocated_storage = 20
        parameter_group_name = "challenge-two-public-a"
        skip_final_snapshot = true

    }