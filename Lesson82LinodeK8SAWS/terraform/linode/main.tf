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


resource "local_file" "ip" {
  filename = "linode_ip.txt"
  content  = "The Linode with name ${linode_instance.linodePC.label} is created. The ip address is: ${linode_instance.linodePC.ip_address}"
}

# Create a Linode instance
resource "linode_instance" "linodePC" {
  region          = var.region
  type            = "g6-nanode-1"
  label           = var.label
  image           = "linode/ubuntu24.04"
  authorized_keys = var.ssh_keys
  root_pass       = var.root_pass
}

# hard disk 10 gb
resource "linode_volume" "example_volume" {
  label     = "example-volume"
  size      = 10
  region    = linode_instance.linodePC.region
  linode_id = linode_instance.linodePC.id
}

output "linode_ip" {
  value = linode_instance.linodePC.ip_address
}

output "volume_id" {
  value = linode_volume.example_volume.id
}

