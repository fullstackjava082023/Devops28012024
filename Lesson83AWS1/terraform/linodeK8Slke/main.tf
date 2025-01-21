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



resource "linode_lke_cluster" "lke_minimal" {
  label = "minimal-lke-cluster"
  region = "us-central"  # Choose your preferred Linode region
  k8s_version = "1.31"   # Specify the Kubernetes version

  pool {
    type  = "g6-standard-1"  # Standard type for the node pool
    count = 2              # Number of nodes in the pool
  }
}

resource "local_file" "kubeconfig_yaml" {
    content  = base64decode(linode_lke_cluster.lke_minimal.kubeconfig) # Decode and save the kubeconfig
    filename = "C:/Users/Iliap/.kube/config"    # File path for the kubeconfig.yaml
}


