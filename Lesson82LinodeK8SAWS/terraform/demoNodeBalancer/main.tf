resource "linode_instance" "linode1" {
    label = "linode1_ubuntu"
    image = "linode/ubuntu24.04"
    region = "us-central"
    type = "g6-nanode-1"
    authorized_keys = var.ssh_keys
    root_pass = var.root_pass
    private_ip = true

    
}


resource "linode_instance" "linode2" {
    label = "linode2_centos"
    image = "linode/centos-stream9"
    region = "us-central"
    type = "g6-nanode-1"
    authorized_keys = var.ssh_keys
    root_pass = var.root_pass
    private_ip = true
}

resource "linode_firewall" "my_firewall" {
    label = "my_firewall1"
    inbound {
        label = "allow-http"
        action = "ACCEPT"
        protocol = "TCP"
        ports = "80"
        ipv4 = ["0.0.0.0/0"]
      
    }

    inbound {
        label = "allow-ssh"
        action = "ACCEPT"
        protocol = "TCP"
        ports = "22"
        ipv4 = ["0.0.0.0/0"]
    }

     outbound {
        label    = "accept-ssh"
        action   = "ACCEPT"
        protocol = "TCP"
        ports    = "443"
        ipv4     = ["0.0.0.0/0"]
        ipv6     = ["::/0"]
    }   
      
    inbound_policy = "ACCEPT"
    outbound_policy = "ACCEPT"

    linodes = [linode_instance.linode1.id, linode_instance.linode2.id]
}

#Node Balancer (load balancer)
resource "linode_nodebalancer" "lb" {
    region = "us-central"
    label = "my-lb"
}

resource "linode_nodebalancer_config" "lb_config" {
    nodebalancer_id = linode_nodebalancer.lb.id
    port = 80
    protocol = "http"
    algorithm = "roundrobin"
}

resource "linode_nodebalancer_node" "lb_node1" {
    nodebalancer_id = linode_nodebalancer.lb.id
    config_id = linode_nodebalancer_config.lb_config.id
    label = "linode1"
    address = "${linode_instance.linode1.private_ip_address}:80"  
}

resource "linode_nodebalancer_node" "lb_node2" {
    nodebalancer_id = linode_nodebalancer.lb.id
    config_id = linode_nodebalancer_config.lb_config.id
    label = "linode2"
    address = "${linode_instance.linode2.private_ip_address}:80"  
}

data "linode_instances" "all-instances" {

}

data "linode_regions" "filtered-regions" {
    filter {
        name = "country"
        values = ["us"]
    }
}





