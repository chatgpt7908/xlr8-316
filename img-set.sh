#!/bin/bash

# Install Apache if not installed
if ! command -v httpd &> /dev/null; then
  echo "Installing Apache HTTP Server..."
  sudo dnf install httpd -y
fi

# Enable and start Apache service
sudo systemctl enable httpd
sudo systemctl start httpd

# Create images directory for serving files
sudo mkdir -p /var/www/html/images

# Copy qcow2 and iso files to Apache images directory
sudo cp *.qcow2 /var/www/html/images/ 2>/dev/null
sudo cp *.iso /var/www/html/images/ 2>/dev/null

# Set ownership and permissions
sudo chown -R apache:apache /var/www/html/images
sudo chmod -R 755 /var/www/html/images

# Restart Apache to load new content
sudo systemctl restart httpd

# Get server IP address to display URL
SERVER_IP=$(hostname -I | awk '{print $1}')

echo "Apache HTTP Server is running."
echo "Your images are available at: http://$SERVER_IP/images/"

