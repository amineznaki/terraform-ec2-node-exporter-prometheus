resource "aws_security_group" "Security_Group_Node_Exporter" {
  name        = "SecurityGroupNodeExporter"
  description = "Node Exporter"
  
  ingress {
    from_port   = 22  
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
  
  ingress {
    from_port   = 9100   
    to_port     = 9100
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


resource "aws_instance" "node_exporter_instance" {
  ami           = "ami-0c38b837cd80f13bb"  
  instance_type = "t2.micro"
    key_name = "prometheus"
  tags = {
    Name = "NodeExporterInstance"
  }

  vpc_security_group_ids = [aws_security_group.Security_Group_Node_Exporter.id]
}
