locals {
  region = "us-west-1"
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eb-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]


  enable_nat_gateway = false
  single_nat_gateway = true

  tags = {
    Owner       = "ALOK.RAJ"
    Environment = "Terraform"
  }

  vpc_tags = {
    Name = "eb-vpc"
  }
}

################################################################################
# Elastic BeanStalk Module
################################################################################

data "aws_elastic_beanstalk_solution_stack" "php_latest" {
  most_recent = true

  name_regex = "^64bit Amazon Linux (.*) running PHP 8.0$"
}

module "eb" {
  source = "./modules_eb"

  eb_app_name = var.eb_app_name
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.php_latest.name
}
