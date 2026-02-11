variable "github_token" {
  description = "GitHub token with repo and environment access."
  type        = string
  sensitive   = true
}

variable "github_repository" {
  description = "The full name of the GitHub repository (e.g., 'owner/repo')."
  type        = string
}