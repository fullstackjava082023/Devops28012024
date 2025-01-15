terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~>6.4.0"
    }
    linode = {
      source  = "linode/linode"
      version = "~>2.25.0"
    }
  }
}

provider "github" {
  token = var.github_token
}
