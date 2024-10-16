# Security Group for Prometheus
resource "aws_security_group" "Security_Group_Prometheus" {
  name        = "SecurityGroupPrometheus"
  description = "Prometheus"

  ingress {
    from_port   = 22  
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
  
  ingress {
    from_port   = 9090  
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "prometheus_instance" {
  ami           = "ami-0c38b837cd80f13bb"  
  instance_type = "t2.micro"
  key_name = "prometheus"
  root_block_device {
    volume_size = 25
    volume_type = "gp2"
  }
  tags = {
    Name = "PrometheusInstance"
  }

  vpc_security_group_ids = [aws_security_group.Security_Group_Prometheus.id]
}
