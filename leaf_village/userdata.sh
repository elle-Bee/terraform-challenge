#!/bin/bash
apt update -y
apt install -y nginx
systemctl start nginx
git clone https://github.com/himanshiparnami/psychic-disco.git
cd psychic-disco
sed -i "s/TeamName/${team_name}/" leaf_village.html
cp leaf_village.html /var/www/html/index.html
systemctl restart nginx