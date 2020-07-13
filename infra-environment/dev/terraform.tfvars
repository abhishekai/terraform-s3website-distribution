####################################################
## Define all required Variables for Dev Environment
## Author: Abhishek Srivastava
####################################################

aws_region = "us-east-1"
project_name = "s3DistributionViaCF"
#User associated with these keys should have required priviliges to perform actions on AWS resources being used for this module,
#however, please avoid using keys if possible, either go for aws vault to set up local machine with AWS or use aws credentials file
aws_access_key = "XXXXXXXXXXXXXXXXXXX"
aws_secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXX"
domain = "dataoncloud.tk"
product_domain = "doc"
environment = "dev"