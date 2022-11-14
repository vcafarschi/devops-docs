provider "aws" {
  profile                 = "default"
  shared_credentials_file = "/Users/vladislav.cafarschi/.aws/credentials"
  region                  = local.region
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.63.0"
    }
  }

}


locals {
  name   = "aurora-postgresql"
  region = "us-east-1"
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.name
  cidr = "10.1.0.0/16"

  azs              = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets   = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  private_subnets  = ["10.1.4.0/24", "10.1.5.0/24", "10.1.6.0/24"]
  database_subnets = ["10.1.7.0/24", "10.1.8.0/24", "10.1.9.0/24"]

  create_database_subnet_group = false

  tags = local.tags
}

module "aurora" {
  source = "../"

  name           = local.name
  engine         = "aurora-postgresql"
  engine_version = "11.12"
  ## Maybe to change from map to object ?
  instances = {
    1 = {
      instance_class      = "db.t3.small"
      publicly_accessible = true
    }
    2 = {
      identifier     = "static-member-1"
      instance_class = "db.t3.small"
    }
    3 = {
      identifier     = "excluded-member-1"
      instance_class = "db.t3.small"
      promotion_tier = 15
    }
  }

  # endpoints = {
  #   static = {
  #     identifier     = "static-custom-endpt"
  #     type           = "ANY"
  #     static_members = ["static-member-1"]
  #     tags           = { Endpoint = "static-members" }
  #   }
  #   excluded = {
  #     identifier       = "excluded-custom-endpt"
  #     type             = "READER"
  #     excluded_members = ["excluded-member-1"]
  #     tags             = { Endpoint = "excluded-members" }
  #   }
  # }

  
  ### DB subnet group
  create_db_subnet_group = true
  db_subnet_group_name   = "aurora-postgre-test"
  subnet_ids             = ["subnet-0cc7d3b7c3a07f6cd","subnet-08688bfb750aede73","subnet-0b71d9c27106e9d6a"]

  ### Cluster Parameter group and Instance Parameter group
  create_cluster_parameter_group  = true
  db_cluster_parameter_group_name = "aurora-postgresql11-test"
  cluster_parameters              = []

  create_instance_db_parameter_group       = true
  db_instance_parameter_group_name         = "aurora-postgresql11-test-test"
  instance_parameters                      = []

  parameter_group_family = "aurora-postgresql11"

  ### Security groups
  vpc_id                          = module.vpc.vpc_id
  create_security_group           = true
  # existing_security_group_id      = ""
  allowed_cidr_blocks             = module.vpc.private_subnets_cidr_blocks
  allowed_security_groups         = []
  security_group_egress_rules     = {
    to_cidrs = {
      cidr_blocks = ["10.33.0.0/28"]
      description = "Egress to corporate printer closet"
    }
  }

  ### Authentication
  iam_database_authentication_enabled = true
  master_password                     = "123456abcd"
  create_random_password              = false

  apply_immediately   = true
  skip_final_snapshot = true


  # enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = local.tags
}
