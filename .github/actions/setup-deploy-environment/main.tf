terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}

# Configure the GitHub provider
provider "github" {
  # The token will be sourced from GITHUB_TOKEN environment variable in the workflow
  token = var.github_token
  owner = "amsrun"
  write_delay_ms = 3000
  retry_delay_ms = 2000
}

data "github_repository" "this" {
  name = var.github_repository
}

data "github_team" "dp_reviewers" {
  slug = "dp-reviewers"
}

data "github_team" "dp" {
  slug = "dp"
}

data "github_user" "current" {
  username = "whichwit"
}

data "github_users" "managers" {
  usernames = ["whichwit"]
}