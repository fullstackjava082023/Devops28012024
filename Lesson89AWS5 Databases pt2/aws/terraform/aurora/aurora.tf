# Define the provider
provider "aws" {
  region = "us-east-1"
}


resource "aws_rds_cluster" "aurora" {
  cluster_identifier = "auroraclusterterra2"
  engine             = "aurora-mysql"
  engine_mode        = "provisioned" # Can also use "serverless" for intermittent workloads
  database_name      = "mydatabaseterra2"
  master_username    = "admin"
  master_password    = "12345678"
  backup_retention_period = 1 # Set to 1 day to minimize cost
  preferred_backup_window  = "03:00-04:00"


  # Associate the RDS cluster with the security group
  vpc_security_group_ids = ["sg-0b013b8afc4b02785"]
 

  storage_encrypted = true

  # Deletion protection off for dev/test environment
  deletion_protection = false

  tags = {
    Name = "Aurora-Cluster"
  }
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  identifier        = "aurora-instance"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class    = "db.t4g.medium" # Small instance to minimize cost
  engine            = aws_rds_cluster.aurora.engine
  publicly_accessible = true

  tags = {
    Name = "Aurora-Instance"
  }
}

# Output the database endpoint
output "db_endpoint" {
  value = aws_rds_cluster_instance.aurora_instance.endpoint
  description = "The connection endpoint for the RDS aurora_instance."
}
