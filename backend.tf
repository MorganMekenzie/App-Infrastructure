terraform {
  backend "s3" {
    bucket         = "ta-challenge-wp-team-4"
    key            = "Talent-Academy/application/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}