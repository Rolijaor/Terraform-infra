terraform {
  backend "s3" {
    bucket         = "migra-aws-tfstate"
    key            = "prod/terraform.tfstate"   
    region         = "eu-south-2"
    dynamodb_table = "migra-aws-locks"
    encrypt        = true
  }
}
