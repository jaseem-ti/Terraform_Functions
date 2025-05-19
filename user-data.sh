#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo git clone https://github.com/saikiranpi/SecOps-game.git
sudo rm -rf /var/www/html/index.nginx-debian.html
sudo cp -r SecOps-game/index.html /var/www/html/
echo "<h1>${var.vpc_name}-public-Server-${count.index + 1} >> /var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
#testing
#testing
#testing