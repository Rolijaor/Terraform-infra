output "aurora_endpoint" {
  value       = aws_rds_cluster.aurora.endpoint
  description = "Endpoint de Aurora MySQL"
}

output "redshift_endpoint" {
  value       = aws_redshift_cluster.rs.endpoint
  description = "Endpoint de Redshift"
}
