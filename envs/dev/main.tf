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
  az_with_nat = "eu-south-2a"
}

# 4.2 Almacenamiento y backups
module "storage" {
  source         = "../../modules/storage"
  project_name   = var.project_name
  lifecycle_days = 15
  # client_usernames usará el valor por defecto definido en variables.tf
}

# 4.3 Bases de datos (Aurora + Redshift)
module "database" {
  source                       = "../../modules/database"
  project_name                 = var.project_name
  aurora_instance_class        = "db.t3.small"
  aurora_instances             = 2
  aurora_backup_retention_days = 15

  redshift_node_type       = "dc2.large"
  redshift_node_count      = 2
  redshift_master_user     = var.redshift_master_user
  redshift_master_password = var.redshift_master_password
}

# 4.4 Cómputo (EC2 Relay + ECS/Fargate)
module "compute" {
  source              = "../../modules/compute"
  project_name        = var.project_name
  tailscale_key       = var.tailscale_key
  erp_image           = var.erp_image

  relay_ami           = "ami-0c94855ba95c71c99"
  relay_instance_type = "t3.micro"

  subnet_ids          = module.network.private_subnet_ids
  security_group_ids  = [aws_security_group.ecs.id]  # Notas debo definir este SG en dev/main.tf :)

  ecs_cpu             = 512
  ecs_memory          = 2048
  ecs_desired_count   = 1

  awslogs_group       = "/ecs/erp"
  region              = var.region
}
