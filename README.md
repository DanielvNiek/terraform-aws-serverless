# terraform-aws-serverless
This repo uses Terraform together with Github Actions to create the AWS resources required for most serverless projects. A single AWS account is used with eu-west-1 being for production and us-east-1 for development.

# Deploy to dev
terraform apply
# Deploy to prod
terraform apply -state=prod.tfstate -var="stage=prod" -var="region=eu-west-1"

