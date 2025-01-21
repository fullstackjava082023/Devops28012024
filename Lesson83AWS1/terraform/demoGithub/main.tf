resource "github_repository" "arya" {
  name = "arya1"
  description = "this is Winterfell repository"
}

resource "github_branch" "development" {
  repository = github_repository.arya.name
  branch = "development"
}


resource "github_repository_webhook" "my_hook" {
    repository = github_repository.arya.name
    events     = ["push"]
    configuration {
        url          = "http://${linode_instance.name.ip_address}:5000/webhook"
        content_type = "json"
    }
}


resource "linode_instance" "name" {
    label = "my-instance"
    region = "us-east"
    type = "g6-nanode-1"
    image = "linode/ubuntu20.04"
    root_pass = "password"
    tags = ["web", "app"]
  
}