resource "aws_elastic_beanstalk_application" "tftest" {
  name        = var.eb_app_name
  description = var.eb_app_name
}

resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name                = var.eb_app_name
  application         = aws_elastic_beanstalk_application.tftest.name
  solution_stack_name = var.solution_stack_name
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.public_subnets)
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     =  "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "aws-elasticbeanstalk-service-role"
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "ConfigDocument"
    resource  = ""
    value     = jsonencode(
                    {
                       Rules             = {
                           Environment = {
                               Application = {
                                   ApplicationRequests4xx = {
                                       Enabled = false
                                    }
                                }
                               ELB         = {
                                   ELBRequests4xx = {
                                       Enabled = false
                                    }
                                }
                            }
                        }
                       Version           = 1
                    }
                )
  }
}



