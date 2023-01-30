# public ip output
output "public-ip" {
  description = "The Public IP address of the web server"
  #    value       = aws_instance.web.public_ip
  value = "${aws_instance.web_pub.public_ip}:${var.server_port}"
}

# private ip output
output "private-ip" {
  description = "The Private IP address of the web server"
  value       = aws_instance.web_pri.private_ip
}

# DB endpoint
output "db_endpoint" {
  description = "The Endpoint IP address of the DB server"
  value       = aws_db_instance.tf-db.endpoint
}