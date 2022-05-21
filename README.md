# elastic-beanstalk-project

Setup AWS Credentials:

aws configure

Configure AWS CLI to make use of STS and generate temporary/short-term credentials to use with Terraform:

aws sts get-session-token \
    --duration-seconds no_of_seconds

ERROR: An error occurred (RegionDisabledException) when calling the GetSessionToken operation: STS is not activated in this region for account:751555341958. Your account administrator can activate STS in this region using the IAM Console.

Terraform:

Creates VPC with 2 public and 2 private subnets with IGW attached. Does not create NAT Gateway.
To create NAT Gateway, set enable_nat_gateway = true

Elastic Beanstalk creates an environment for a sample PHP app, with desired configuration:
    1. Ignore HTTP 4xx: enable
    2. Ignore load balancer 4xx: enable

Access the application using the endpoint generated in Terraform output: cname or lb_endpoint.