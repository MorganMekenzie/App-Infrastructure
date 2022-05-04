#DATA SOURCE FOR AMI
data "aws_ami" "aws_basic_linux" {
  owners      = [var.aws_owner_id]
  most_recent = true
  filter {
    name   = "name"
    values = [var.aws_ami_name]
  }
}

data "aws_vpc" "canary_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }

}
data "aws_subnet" "private_a" {
  filter {
    name   = "tag:Name"
    values = [var.private_a_subnet_name]
  }

}

data "aws_subnet" "private_b" {
  filter {
    name   = "tag:Name"
    values = [var.private_b_subnet_name]
  }

}