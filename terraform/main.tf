terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    docker = {
      source    = "kreuzwerker/docker"
      version   = "~> 2.20.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_ecs_cluster" "thoughts_cluster" {
  name = "thoughts-cluster"
}


