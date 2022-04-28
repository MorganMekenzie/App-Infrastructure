resource "aws_db_instance" "default" {
  # ... other configuration ...

  allocated_storage     = 50
  max_allocated_storage = 100
}