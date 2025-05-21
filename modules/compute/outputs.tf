output "relay_private_ip" {
  value       = aws_instance.tailscale_relay.private_ip
  description = "IP privada del relay Tailscale"
}

output "ecs_cluster_id" {
  value       = aws_ecs_cluster.erp.id
  description = "ID del cluster ECS"
}
