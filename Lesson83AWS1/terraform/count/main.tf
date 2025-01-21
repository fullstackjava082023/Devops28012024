terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.25.0"
    }
  }
}

provider "linode" {
  token = var.token
}


resource "linode_instance" "dbs" {
  count = 3  
  region = var.region
  type = "g6-standard-1"
  label = "${var.label}-${count.index}"
  root_pass = var.root_pass
  
}