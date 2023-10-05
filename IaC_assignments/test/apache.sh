#!/bin/bash
#updates the VMs OS
sudo su
apt update 
apt upgrade -y

#Installs the apache 2 webserver
apt install apache2 -y

#enables and restarts the webserver service
systemctl enable apache2
systemctl restart apache2