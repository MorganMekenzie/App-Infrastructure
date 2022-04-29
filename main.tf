data "aws_secretsmanager_secret" "secrets" {
  name = "WordPress_DB_Credentials"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

data "aws_subnet" "data_a" {
  filter {
    name   = "tag:Name"
    values = ["canary-vpc-data-a"]
  }
}

data "aws_subnet" "data_b" {
  filter {
    name   = "tag:Name"
    values = ["canary-vpc-data-b"]
  }
}


# output "sensitive_example_hash" {
#  value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.current.secret_string))
# }