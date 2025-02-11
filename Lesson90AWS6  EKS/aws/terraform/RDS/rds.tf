provider "aws" {
    region = "us-east-1"
  
}


resource "aws_db_instance" "default" {
    allocated_storage    = 20
    storage_type         = "gp2"
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t4g.micro" 
    identifier                 = "mydb-terra"
    username             = "admin"
    password             = "12345678"
    publicly_accessible  = true
    skip_final_snapshot  = true
    vpc_security_group_ids = ["sg-0b013b8afc4b02785"]
}