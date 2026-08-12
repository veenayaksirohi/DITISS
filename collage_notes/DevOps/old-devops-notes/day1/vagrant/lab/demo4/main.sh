#!/bin/bash

echo ""
echo ""
echo ""
echo "******************************"
echo "Installation started"
sleep 5
sudo apt update -y
sudo apt install apache2 -y
echo "Hello from vagrant machine......" | sudo tee /var/www/html/index.html
echo "***************"
echo "Installation completed"
sleep 5