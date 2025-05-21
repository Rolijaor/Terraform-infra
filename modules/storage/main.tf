resource "aws_s3_bucket" "backups" {
  bucket = "${var.project_name}-backups"
  acl    = "private"

  versioning { enabled = true }

  lifecycle_rule {
    id      = "GlacierTransition"
    enabled = true
    prefix  = ""
    transition {
      days          = var.lifecycle_days
      storage_class = "GLACIER"
    }
  }
}

resource "aws_transfer_server" "sftp" {
  identity_provider_type = "SERVICE_MANAGED"
  protocols              = ["SFTP"]
  endpoint_type          = "PUBLIC"
}

resource "aws_transfer_user" "clients" {
  for_each      = toset(var.client_usernames)
  server_id     = aws_transfer_server.sftp.id
  user_name     = each.value
  role          = aws_iam_role.transfer_role.arn
  home_directory = "/${aws_s3_bucket.backups.bucket}"
}
