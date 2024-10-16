# terraform-ec2-node-exporter-prometheus
This repository contains Terraform scripts to provision two EC2 instances on AWS and automate the installation of Node Exporter and Prometheus for monitoring purposes.

## Setup Instructions

### 1. Clone the Repository
git clone <your-repo-url> cd <your-repo-directory>

### 2. Configure the PEM File

1. Place your PEM file in the project directory.
2. Update the PEM file path in both `main.tf` and `node.tf`.

### 3. Terraform Setup

1. Initialize Terraform:
terraform init

2. Apply the Terraform configuration:
terraform apply


### 4. Run Installation Scripts

- SSH into the main server 
ssh -i <path_to_your_pem_file> ubuntu@<ip_of_your_main_server> 


- SSH into the node server (Node Exporter) :
ssh -i <path_to_your_pem_file> ubuntu@<ip_of_your_main_server> 

### 5. Run Installation Scripts

- Run the Prometheus installation script on the main server: 

- Run the Node Exporter installation script on the node server:

### 6. Integrate Node Exporter with Prometheus

1. Update `prometheus.yml` on the Prometheus server:
targets: ['<ip_of_your_node_server>:9100']


2. Restart the Prometheus service to apply the changes.

## Monitoring Services

- **Prometheus**: Access at `http://<ip_of_your_main_server>:9090`.
- **Node Exporter**: Access metrics at `http://<ip_of_your_node_server>:9100/metrics`.

## Requirements

- **Terraform**: Installed on your local machine.
- **AWS Account**: Permissions to create EC2 instances.
- **PEM File**: Valid PEM file for SSH access.

## Notes

- Ensure AWS Security Groups allow inbound traffic on the required ports.







