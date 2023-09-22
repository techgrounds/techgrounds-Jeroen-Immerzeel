#!/bin/bash
#set rights
sudo su
#update the system
apt update
apt upgrade -y
#install apache2
apt install apache2 -y
#enable and restart the apache2 service
systemctl enable apache2
systemctl restart apache2
