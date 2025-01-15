output "linode1_ip" {
    value = {
        public_ip = linode_instance.linode1.ip_address
        private_ip = linode_instance.linode1.private_ip_address
    }
  
}

output "linode2_ip" {
     value = {
        public_ip = linode_instance.linode2.ip_address
        private_ip = linode_instance.linode2.private_ip_address
    }
  
}

output "cpu_linode1" {
  value = data.linode_instances.all-instances.instances[0].specs[0].vcpus
}

output "all_regions" {
  value = {
     region = data.linode_regions.filtered-regions.regions[0].id
     country = data.linode_regions.filtered-regions.regions[0].country
     label = data.linode_regions.filtered-regions.regions[0].label
  }
  
}