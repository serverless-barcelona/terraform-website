terraform {
  required_version = ">= 1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "local" {
    path = "terraform.tfstate"
  }    
}

provider "aws" { 
  region     = "eu-west-1"
}

provider "aws" {
  alias   = "use1"
  region  = "us-east-1"
}