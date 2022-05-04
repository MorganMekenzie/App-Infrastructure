terraform {
  backend "s3" {
    bucket         = "ta-challenge-wp-team-4"
    key            = "Talent-Academy/rds/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}