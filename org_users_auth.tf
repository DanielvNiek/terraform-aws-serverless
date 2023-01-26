## create aws provider
provider "aws" {
  region = var.region
}

## create region input variable
variable "region" {
  default = "us-east-1"
  type = string
}
## create stage input variable
variable "stage" {
  default = "dev"
  type = string
}

## create cognito user pool with email as alias, disabled self-service sign-up and 10 developer only custom attributes starting with the letter o and ending with the number 1-10
resource "aws_cognito_user_pool" "OrgUserPool" {
    ##add lifecycle to ignore changes to schema
    lifecycle {
        ignore_changes = [schema]
    }
  admin_create_user_config {
    allow_admin_create_user_only = true
  }
  name = "OrgUserPool-${var.stage}"
  alias_attributes = ["email"]
  schema {
    name = "o1"
    attribute_data_type = "String"
    developer_only_attribute = true
    mutable = true
  }
  schema {
    name = "o2"
    attribute_data_type = "String"
    developer_only_attribute = true
    mutable = true
  }
  schema {
    name = "o3"
    attribute_data_type = "String"
    developer_only_attribute = true
    mutable = true
  }
  schema {
    name = "o4"
    attribute_data_type = "String"
    developer_only_attribute = true
    mutable = true
  }
  schema {
    name = "o5"
    attribute_data_type = "String"
    developer_only_attribute = true
    mutable = true
  }
  schema {
    name = "o6"
    attribute_data_type = "String"
    developer_only_attribute = true
    mutable = true
  }
  schema {
    name = "o7"
    attribute_data_type = "String"
    developer_only_attribute = true
    mutable = true
  }
  schema {
    name = "o8"
    attribute_data_type = "String"
    developer_only_attribute = true
    mutable = true
  }
  schema {
    name = "o9"
    attribute_data_type = "String"
    developer_only_attribute = true
    mutable = true
  }
  schema {
    name = "o10"
    attribute_data_type = "String"
    developer_only_attribute = true
    mutable = true
  }
}

## create cognito app client with no client secret, implicit grant, 5 minute token expiration, and 10 minute refresh token expiration
resource "aws_cognito_user_pool_client" "OrgUserPoolClient" {
  name = "OrgUserPoolClient-${var.stage}"
  user_pool_id = aws_cognito_user_pool.OrgUserPool.id
  generate_secret = false
  explicit_auth_flows = ["ALLOW_USER_SRP_AUTH","ALLOW_REFRESH_TOKEN_AUTH","ALLOW_CUSTOM_AUTH","ALLOW_USER_PASSWORD_AUTH","ALLOW_ADMIN_USER_PASSWORD_AUTH"]
  allowed_oauth_flows = ["implicit"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes = ["phone", "email", "openid", "profile", "aws.cognito.signin.user.admin"]
  callback_urls = ["https://localhost:3000"]
  logout_urls = ["https://localhost:3000"]
  supported_identity_providers = ["COGNITO"]
  refresh_token_validity = 10
  access_token_validity = 5
}

## create cognito identity pool that does not allow unauthenticated identities and has cognito user pool as provider
resource "aws_cognito_identity_pool" "OrgUserIdentityPool" {
  identity_pool_name = "OrgUserIdentityPool-${var.stage}"
  allow_unauthenticated_identities = false
  cognito_identity_providers {
    client_id = aws_cognito_user_pool_client.OrgUserPoolClient.id
    provider_name = aws_cognito_user_pool.OrgUserPool.endpoint
    server_side_token_check = true
  }
}


## create authenticated role with cognito identity pool as principal allowing lambda invoke function url if function name starts with or-
resource "aws_iam_role" "OrgUserAuthenticatedRole" {
  name = "OrgUserAuthenticatedRole-${var.stage}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Principal = {
          Federated = "cognito-identity.amazonaws.com"
        }
        Condition = {
          StringEquals = {
            "cognito-identity.amazonaws.com:aud" = aws_cognito_identity_pool.OrgUserIdentityPool.id
          }
          "ForAnyValue:StringLike" = {
            "cognito-identity.amazonaws.com:amr" = "authenticated"
          }
        }
        Effect = "Allow"
      }
    ]
  })
  inline_policy {
    name = "LambdaInvokePolicy-${var.stage}"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "lambda:InvokeFunctionUrl"
          ]
          Effect = "Allow"
          Resource = [
            "arn:aws:lambda:${var.region}:*:function:or-*"
          ]
        }
      ]
    })
  }
}

## create lambda invoke policy allowing lambda invoke function url if function name starts with or-
resource "aws_iam_policy" "LambdaInvokePolicy" {
  name = "LambdaInvokePolicy-${var.stage}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "lambda:InvokeFunction"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:lambda:${var.region}:*:function:or-*"
      ]
    }
  ]
}
EOF
}

## create lambda invoke policy attachment for authenticated role
resource "aws_iam_role_policy_attachment" "LambdaInvokePolicyAttachment" {
  role = aws_iam_role.OrgUserAuthenticatedRole.name
  policy_arn = aws_iam_policy.LambdaInvokePolicy.arn
}

## create cognito identity pool roles attachment
resource "aws_cognito_identity_pool_roles_attachment" "OrgUserIdentityPoolRolesAttachment" {
  identity_pool_id = aws_cognito_identity_pool.OrgUserIdentityPool.id
  roles = {
    authenticated = aws_iam_role.OrgUserAuthenticatedRole.arn
  }
}















