# **Using Terraform to Create an AWS VPC Peering**

Hi, Welcome to the first in the VPC Peering Series.

In this edition, you will learn how to create and peer VPCs together that are in the same region. This shows how to create VPC peering on AWS using terraform.
<br>
<br>

## __What is AWS VPC Peering?__
Amazon Web Services (AWS) Virtual Private Cloud (VPC) peering is a networking feature that allows you to connect two VPCs together, enabling communication between them as if they were on the same network. VPC peering is a private and secure connection, which means traffic between the peered VPCs stays within the AWS network and does not traverse the public internet.
<br>
<br>
![yaml file](./img/VPC.png)
<br>
<br>
<br>
<br>

## __TERRAFORM SCRIPT__
<br>

### __*Provider File*__
<li> Contents of the terraform file.
<br>
![VPC](./images/1.png)
<br>
<br>

### __*VPC File*__
<li> Contents of the terraform file.
<br>
![VPC](./images/1.png)
<br>
<br>

### __*Security Group File*__
<li> Contents of the terraform file.
<br>
![VPC](./images/1.png)
<br>
<br>

### __*EC2 Instance File*__
<li> Contents of the terraform file.
<br>
![VPC](./images/1.png)
<br>
<br>

### __*Variables File*__
<li> Contents of the terraform file.
<br>
![VPC](./images/1.png)
<br>
<br>
<br>

## __TESTING THE SCRIPT__
<br>

### __*Terraform init*__
<li> This shows what happened after terraform has been initialiazed.
<br>
![VPC](./images/1.png)
<br>
<br>

### __*Terraform plan*__
<li> This shows the content after all the services has been created using the above terraform script.
<br>
![VPC](./images/1.png)
<br>
<br>

### __*EC2 Test*__
<li> Here the Requester instance on the requester vpc pings the Accepter instance on the accepter vpc for us to see that that both VPCs are peered.
<br>
![VPC](./images/1.png)
<br>
<br>

## __CONCLUSION__
<br>
In conclusion VPC peering is useful for scenarios where you want to share resources, services, or data securely between separate VPCs, such as connecting development and production environments, sharing databases, or integrating different applications within your AWS infrastructure. It provides a convenient way to build complex multi-tier architectures in a scalable and isolated manner. As shown above, its shows the connection between 2 ec2 instances on different VPCs connecting with each other via the VPC Peering