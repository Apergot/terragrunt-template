generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "aws" {
      region  = "eu-west-1"
      profile = "tf_aperdomo"
    }
  EOF
}

generate "base_variables" {
  path = "base_variables.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
    variable "environment" {
      default = "dev"
      type = string
      description = "target environment"
    }

    variable "region" {
      default = "eu-west-1"
      type = string
      description = "aws region"
    }

    variable "default_tags" {
      default = {Owner = "aperdomo", Environment: "dev"}
      type = object({
        Owner = string
        Environment = string
      })
      description = "Mapping of tags to assign to resources"
    }
  EOF
}

remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    profile = "tf_aperdomo"
    bucket = "tf-remote-state"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "eu-west-1"
    encrypt = true
    dynamodb_table = "terragrunt-lock-table"
  }
}