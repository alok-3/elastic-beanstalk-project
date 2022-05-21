output "cname" {
  value       = aws_elastic_beanstalk_environment.tfenvtest.cname
}

output "lb_endpoint" {
  value       = aws_elastic_beanstalk_environment.tfenvtest.endpoint_url
}