terraform {
  backend "s3" {
    bucket         = "brava-tfstate-812326499495"
    key            = "aws-cloud-cicd/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "brava-terraform-locks"
  }
}
