output "vpc_id" {
  description = "ID de la VPC desplegada"
  value       = module.network.vpc_id
}

output "private_subnets" {
  description = "IDs de las subnets privadas"
  value       = module.network.private_subnets
}

output "s3_backups_bucket" {
  description = "Nombre del bucket de backups"
  value       = module.storage.bucket_name
}

output "aurora_endpoint" {
  description = "Endpoint de Aurora MySQL"
  value       = module.database.aurora_endpoint
}

output "redshift_endpoint" {
  description = "Endpoint de Redshift"
  value       = module.database.redshift_endpoint
}

output "ecs_cluster_id" {
  description = "ID del cluster ECS"
  value       = module.compute.ecs_cluster_id
}

output "tailscale_relay_ip" {
  description = "IP privada del EC2 relay Tailscale"
  value       = module.compute.relay_private_ip
}
