output "vpc_id" {
  value       = aws_vpc.this.id
  description = "ID de la VPC"
}

output "private_subnet_ids" {
  value       = values(aws_subnet.private)[*].id
  description = "Lista de IDs de subnets privadas"
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.nat.id
  description = "ID del NAT Gateway"
}
