output "prometheus_instance_public_ip" {
  description = "The public IP address of the Prometheus EC2 instance"
  value       = aws_instance.prometheus_instance.public_ip
}

output "node_exporter_instance_public_ip" {
  description = "The public IP address of the Node Exporter EC2 instance"
  value       = aws_instance.node_exporter_instance.public_ip
}
