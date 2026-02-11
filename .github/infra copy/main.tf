terraform {
	required_providers {
		github = {
			source  = "integrations/github"
			version = "~> 6.0"
		}
	}
}

provider "github" {
	token = var.github_token
	owner = var.github_owner
}

variable "github_token" {
	description = "GitHub token with repo and environment access."
	type        = string
	sensitive   = true
}

variable "github_owner" {
	description = "GitHub org or user that owns the repository."
	type        = string
	default     = "whichwit"
}

variable "github_repository" {
	description = "Repository name to manage environments for."
	type        = string
	default     = "gatest"
}

variable "environment_secrets" {
	description = "Map of environment name to secret name/value pairs."
	type        = map(map(string))
	default     = {}
}

locals {
	environment_secret_pairs = flatten([
		for env, secrets in var.environment_secrets : [
			for name, value in secrets : {
				environment = env
				name        = name
				value       = value
			}
		]
	])
}

resource "github_actions_environment_secret" "this" {
	for_each = {
		for pair in local.environment_secret_pairs : "${pair.environment}.${pair.name}" => pair
	}

	repository      = var.github_repository
	environment     = each.value.environment
	secret_name     = each.value.name
	plaintext_value = each.value.value
}
