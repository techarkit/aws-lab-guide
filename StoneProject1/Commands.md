## Commands to Prepare EC2 Instance ##

sudo apt-get update -y
sudo apt-get install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
git clone https://github.com/awsvishwas/awsproject1.git project1
cd project1/
sudo mv * /var/www/html/
cd /var/www/html/
sudo rm -rf index.html 
sudo add-apt-repository -y ppa:ondrej/php
sudo apt install php5.6 mysql-client php5.6-mysqli -y
sudo mysql -h <EndPoint> -u admin -p

mysql> show databases;
mysql> use intel;
mysql> create table data(firstname varchar(21),email varchar(21));
Query OK, 0 rows affected (0.02 sec)
mysql> quit;

cd /var/www/html
sudo vim /var/www/html/index.php

## Line Number 29 ##
$firstname=$_POST['firstname'];
$email=$_POST['email'];
$servername = "ENDPOINT_URL";
$username = "admin";
$password = "PASSWORD_HERE";
$db = "intel";
// Create connection

:wq!

## To Verify the Data is inserted ##

sudo mysql -h <EndPoint> -u admin -p
mysql> use intel;
mysql> show tables;
mysql> select * from data;
