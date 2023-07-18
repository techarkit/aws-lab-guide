# Multi AZ Deployment, AutoScalling Groups. ###

### 1. Create Key Pair to access Linux EC2 Instance ###
### 2. Create Three Security Groups ###
	a. Create Load Balancer Security Groups (LBSG) Attach to Load Balancer
		a1. Allow Port 80
	b. Create Web Server Security Group (WEBSG) attach to EC2 instances
		b1. Allow Port 80 - http portocol access Custom Allow LBSG 
		b2. Allow Port 22 - SSH to access EC2 instances Allow Any-Where-IPv4
	c. Create EFS Security Group (EFSSG) to allow 2049(NFS) protocol
		c1. Allow 2049 Port and allow WEBSG group as custom to accessed by EC2 instances
### 3. Create EFS Share and copy the attach command ###
	- Specify the EFS Name
	- Select Security Group (EFSSG)
### 4. Create a Target Group ###
	- Target type - Instances
	- Target Group Name - Ex: app1
	- Protocol HTTP = 80
	- Health Checks 
		- HTTP
		- Health check path
		- /checkstatus.html (This page should be available in EC2 instance otherwise health check will fail)
	- Additional health check settings
	- healthy threshold to 3
	- unhealthy threshold to 2
	- Internal is 10 Seconds

### 5. Create Application Load Balancer ###
	- Provide Load Balancer Name (MyALBWebServer)
	- Scheme (Internet-facing)
	- IPv4 Address type
	- Default VPC and Select all the AZ's
	- Security Group is LBSG
	- Select the Target group (Created on step 4)
	- (Create Load Balancer)	

### 6. Create AutoScalling Groups ###
	- Group Name
	- Define Launch Template
		- Template Name
		- Description
		- Select OS (Amazon Linux 2023)
		- Select Instance type (t2.micro)
		- Select KeyPair (you create at the first step)
		- Select the Security Group as (WEBSG)
		- Advanced usage define the shell script to install and start httpd and mount EFS.
  
	```
       #!/bin/bash
			yum update -y
			yum install httpd -y
			systemctl start httpd
			systemctl enable httpd
			sudo mount -t nfs4 -o nfsver=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport <fs.nfs.efs.us.east-1.amazon.com>:/ /var/www/html/
			echo "<h1>Web Server is working fine!</h1>" > /var/www/html/index.html
			echo "<h1> Its Healthy </h1>" > /var/www/html/checkstatus.html

	
	Note: Here replace <fs.nfs.efs.us.east-1.amazon.com> with your EFS path
```
			
