#!/bin/bash

# 1. Mise à jour du système
echo "Updating the system..."
sudo apt update -y

# 2. Création de l'utilisateur et du groupe Prometheus
echo "Creating Prometheus user and group..."
sudo groupadd --system prometheus
sudo useradd -s /sbin/nologin --system -g prometheus prometheus

# 3. Création des répertoires pour Prometheus
echo "Creating directories for Prometheus..."
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

# 4. Téléchargement de Prometheus
echo "Downloading Prometheus..."
wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.43.0.linux-amd64.tar.gz

# 5. Extraction de l'archive Tar
echo "Extracting Prometheus archive..."
tar vxf prometheus-2.43.0.linux-amd64.tar.gz

# 6. Déplacement des fichiers binaires
echo "Moving Prometheus binaries..."
sudo mv prometheus-2.43.0.linux-amd64/prometheus /usr/local/bin/
sudo mv prometheus-2.43.0.linux-amd64/promtool /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool

# 7. Déplacement des fichiers de configuration
echo "Moving configuration files..."
sudo mv prometheus-2.43.0.linux-amd64/consoles /etc/prometheus/
sudo mv prometheus-2.43.0.linux-amd64/console_libraries /etc/prometheus/
sudo mv prometheus-2.43.0.linux-amd64/prometheus.yml /etc/prometheus/
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo chown -R prometheus:prometheus /var/lib/prometheus

# 8. Création du fichier prometheus.service
echo "Creating Prometheus systemd service file..."
sudo tee /etc/systemd/system/prometheus.service > /dev/null <<EOF
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

# 9. Recharger et démarrer Prometheus
echo "Reloading systemd, enabling, and starting Prometheus..."
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

# Vérification du statut de Prometheus
sudo systemctl status prometheus

# 10. Configuration du Pare-feu (Optionnel)
echo "Configuring firewall to allow Prometheus (port 9090)..."
sudo ufw allow 9090/tcp

echo "Prometheus installation and setup complete!"