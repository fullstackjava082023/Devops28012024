terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~>1.0"
    }
  }
}

resource "local_file" "pet" {
    filename = var.file_name
    content = "the random pet is : ${random_pet.mrs_pet.id} and the content from cat is ${data.local_file.cat.content}"
    
}

resource "random_pet" "mrs_pet" {
    length = 1
    prefix = var.prefix
    separator = "."  
}

data "local_file" "cat" {
    filename = "cat.txt"
}

output "random_pet" {
    value = "the random pet is : ${random_pet.mrs_pet.id}"
  
}