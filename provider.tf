terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket         = "aws-platform-ultrastack-bucket" # The one you just created
    key            = "ultrastack/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "ultrastack-tf-lock-table"   # The one you just created
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

