module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "2.2.1"

  for_each = var.repositories

  repository_name = each.value.name
  repository_image_tag_mutability = each.value.mutability

  repository_image_scan_on_push = each.value.scanOnPush

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}