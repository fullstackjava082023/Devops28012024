provider "linode" {
  token = var.linode_api_token
}

# Variables
variable "linode_api_token" {}
variable "k8s_cluster_name" {
  default = "example-k8s-cluster"
}
variable "region" {
  default = "us-central"
}
variable "node_type" {
  default = "g6-standard-2" # 2GB RAM, 1 CPU
}
variable "node_count" {
  default = 2
}

# Kubernetes Cluster
resource "linode_lke_cluster" "k8s_cluster" {
  label  = var.k8s_cluster_name
  region = var.region
  k8s_version = "1.31" # Change this to the desired Kubernetes version

  pool {
    type  = var.node_type
    count = var.node_count
  }
}

# Output the kubeconfig
output "kubeconfig" {
  value = linode_lke_cluster.k8s_cluster.kubeconfig
  sensitive = true
}

# Output the cluster endpoint
output "api_endpoint" {
  value = linode_lke_cluster.k8s_cluster.api_endpoint
}