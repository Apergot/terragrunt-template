variable "repositories" {
  description = "A map of repositories to create"
  type = map(object({
    name       = string
    mutability = string
    scanOnPush = bool
  }))
}