resource "aws_rds_cluster" "aurora" {
  engine                   = "aurora-mysql"
  engine_version           = "5.7.mysql_aurora.2.10.2"
  cluster_identifier       = "${var.project_name}-aurora"
  backup_retention_period  = var.aurora_backup_retention_days
  skip_final_snapshot      = true
  tags                     = { Name = "${var.project_name}-aurora" }
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  count              = var.aurora_instances
  identifier         = "${var.project_name}-aurora-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = var.aurora_instance_class
  engine             = aws_rds_cluster.aurora.engine
  publicly_accessible = false
}

resource "aws_redshift_cluster" "rs" {
  cluster_identifier = "${var.project_name}-redshift"
  node_type          = var.redshift_node_type
  number_of_nodes    = var.redshift_node_count
  database_name      = "analyticsdb"
  master_username    = var.redshift_master_user
  master_password    = var.redshift_master_password
  publicly_accessible = false
  skip_final_snapshot = true
}
