output "repository_urls" {
  description = "The URLs of the ECR repositories (in the form `aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName`)"
  value = { for k, v in module.ecr : k => v.repository_url }
}

output "repository_arns" {
  description = "The ARNs of the ECR repositories"
  value = { for k, v in module.ecr : k => v.repository_arn }
}

output "repository_names" {
  description = "The names of the ECR repositories"
  value = { for k, v in module.ecr : k => v.repository_name }
}

output "repository_registry_id" {
  description = "The registry ID where the repository was created"
  value = { for k, v in module.ecr : k => v.repository_registry_id }
}
