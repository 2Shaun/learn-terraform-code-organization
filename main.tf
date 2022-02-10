terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.74"
    }
  }
}

provider "aws" {
  region = var.region
}

module "aws_s3_static_website" {
  source = "./modules/aws-s3-static-website"
  environments = var.environments
    
}
