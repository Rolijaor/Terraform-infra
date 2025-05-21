provider "aws" {
  region  = var.region
  profile = "migra-aws"
}

# 4.1 Red y red privada
module "network" {
  source       = "../../modules/network"
  project_name = var.project_name
  cidr_block   = "10.0.0.0/16"
  private_cidrs = {
    "eu-south-2a" = "10.0.0.0/24"
    "eu-south-2b" = "10.0.1.0/24"
  }
}

# 4.2 Almacenamiento y backups
module "storage" {
  source       = "../../modules/storage"
  project_name = var.project_name
  bucket_name  = "${var.project_name}-backups"
  lifecycle_days = 15
}

# 4.3 Bases de datos (Aurora + Redshift)
module "database" {
  source         = "../../modules/database"
  project_name   = var.project_name
  aurora_class   = "db.t3.small"
  redshift_nodes = 2
}

# 4.4 Cómputo (EC2 Relay + ECS/Fargate)
module "compute" {
  source         = "../../modules/compute"
  project_name   = var.project_name
  tailscale_key  = var.tailscale_key
  erp_image      = var.erp_image
  ecs_min        = 1
  ecs_max        = 3
}
