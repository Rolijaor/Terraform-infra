output "s3_bucket_name" {
  value       = aws_s3_bucket.backups.bucket
  description = "Nombre del bucket de backups"
}

output "sftp_endpoint" {
  value       = aws_transfer_server.sftp.endpoint
  description = "URL del endpoint SFTP"
}
