#!/bin/bash
set -e


apt-get update -y
apt-get install -y nginx python3

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

cat > /var/www/html/index.html <<HTML
<html>
  <body>
    <h1>${project_name}</h1>
    <p>Served by instance: $INSTANCE_ID in $AZ</p>
    <p>Bootstrapped by user_data - awaiting Ansible configuration.</p>
  </body>
</html>
HTML

systemctl enable nginx
systemctl restart nginx
