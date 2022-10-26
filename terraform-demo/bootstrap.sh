#! /bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo service apache2 start
sudo service apache2 enable
echo "<h1>Hello From $(hostname -f)</h1>" | sudo tee /var/www/html/index.html