#!/bin/bash
##To Install HTTPD Server and Start Service
DEFAULTPATH="/var/www/html/index.html"
sudo yum update –y; 
sudo yum install httpd –y; 
sudo service httpd start;
sudo chkconfig httpd on;

sudo systemctl enable httpd.service;
sudo systemctl start httpd.service;

sudo echo '<html>' > $DEFAULTPATH
sudo echo '<h1> H1! Welcome To My First Website in AWS </h1>' >> $DEFAULTPATH
sudo echo '</html>' >> $DEFAULTPATH

## END ##
