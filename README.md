# devops_challenge
This repository contain solution for three challenges related to 3-tier architecture and json parsing

**.gitignore -** 

# Local .terraform directories
*/.terraform/*

# .tfstate files
*.tfstate
*.tfstate.*

==============================================================================
**Challenge #1**

A 3-tier environment is a common setup. Use a tool of your choosing/familiarity create these resources. Please remember we will not be judged on the outcome but more focusing on the approach, style and reproducibility.

**Solution : **

**Solution folder - ch-1**

I am using terraform to create this 3-tier enviroment on AWS. I am not commiting my tfstate file in github due to security reason. Since this is just a demo thus I am also not saving my tfstate file in remote backend as I am the only one for now doing the changes and maintaining this. Else, we can create remote backend in s3 bucket and use state locking feature using dynamodb.

I have kept this demo simple by creating 3-tier in single availibility zone for sake of simplicity, else we can create the same stack in two availibility zone of an AWS region and in front of Web server tier we can use an application load balancer to route traffic to the backend web server. we then need to restrict security group of web server to only allow inbound (ingress) traffic from application load balancer. This approach will make the 3-tier enviroment highly available. We can also make use of auto scaling group for web and app server stack if we want to ensure more resiliency and availibility. 

**We have created 3-tier environment in AWS using terraform with below details :**

VPC -1
Public Subnet  - 1 -  web-subnet
Private Subnet - 1 - app-subnet
Private subnet - 1 -  DB-subnet
Intenet gateway for public subnet and route table - 1
NAT gateway for private subnet & route table & EIP - 1
web-server - 1
app-server - 1
RDS instance (mysql) - 1
security group - 3 

**Terraform tf configuration file details :**

1) provider.tf - this contain provider information along with region and shared credential file method to authenticate when we need to access our AWS account for resource creation. I have used this method as I already have AWS CLI installed in my local machine so just keeping things simple. We can also use other methods like assume role by specifying role ARN.
2) variable.tf - variable declaration and its default value
3) terraform.tfvars - value assignment for the variable used in terraform configuration files
4) output.tf - just for an example I am taking the web server instance metadata as output using this tf file

**TF configuration files for provisioning various resources in AWS using Terraform:**

1) VPC.tf - for creating VPC, public subnet for web server, private subnet for app server and private subnet for DB server.
2) igw-rt.tf - For creating internet gateway in the VPC for the web server public subnet
3) nat-eip.tf - creating NAT gateway in the public subnet for the outbound traffic to internet for the private subnet for updates and patches.
4) web_ec2.tf - taking ami id from that region and launching web server ec2 instance with user data where I have installed and starting apache web server
5) app_ec2.tf - creating app server ec2 instance for application stack but not deploying any application as this is just a demo.
6) db_instance.tf - creating a mysql database instance 
7) security_group.tf - creating security group for all three tiers to allow traffic from internet to web server, allowing inbound traffic to app server from web server only and finally allowing inbound traffic to db server only from app server.


We can then take the public IP of ouw webserver and check that our web server is running fine or not. 


**Challenge #2**

We need to write code that will query the meta data of an instance within AWS and provide a json formatted output. The choice of language and implementation is up to you.
Bonus Points
The code allows for a particular data key to be retrieved individually

**Solution : **

**Solution folder - ch-2**

I have used terraform output to get the instace metadata. We can then use jq along with it to get any particular key and its value. kq is a light weight JSON processor tool.

**Example-**

# output has been defined as web_server_metadata to get the metadata of an instance
    terraform output -json web_server_metadata | /c/Users/Himanshu/Downloads/jq.exe -r '.'

# to retrieve ami id from the instance metadata 
terraform output -json web_server_metadata | /c/Users/Himanshu/Downloads/jq.exe -r '.ami'

# to retrieve arn from the instnace metadata
terraform output -json web_server_metadata | /c/Users/Himanshu/Downloads/jq.exe -r '.arn'


**Challenge #3**

We have a nested object, we would like a function that you pass in the object and a key and get back the value. How this is implemented is up to you.
Example Inputs
object = {“a”:{“b”:{“c”:”d”}}}
key = a/b/c
object = {“x”:{“y”:{“z”:”a”}}}
key = x/y/z
value = a

**Solution : **

**Solution folder - ch-3**

I have created a function in unix and passing object and key as separate file to get the value back as expected in the example above.
script name -  nested_object.sh
json object file example - f1.json & f2.json
example file containing key - key1.txt & key2.txt 

