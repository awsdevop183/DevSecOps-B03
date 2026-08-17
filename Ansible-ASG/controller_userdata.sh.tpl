#!/bin/bash
set -e

apt-get update -y
apt-get install -y python3 python3-pip git

apt-get install -y software-properties-common git
add-apt-repository --yes --update ppa:ansible/ansible
apt-get install -y ansible
cd /home/ubuntu
git clone -b ansible https://github.com/awsdevop183/DevSecOps-B03.git
cat > /home/ubuntu/DevSecOps-B03/Ansible/ansible.pem <<'KEY'
${file("ansible.pem")}
KEY

chmod 600 /home/ubuntu/DevSecOps-B03/Ansible/ansible.pem
chown ubuntu:ubuntu /home/ubuntu/DevSecOps-B03/Ansible/ansible.pem