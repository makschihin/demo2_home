## To run infrastructure you have to do next:
1. Open terraform folder

2. Go in folder with part of infrasructure which you want to run
    
3. In folder webservers you will see file main.tf

4. In terminal run: 
```zsh
    terraform init (it downloads needed plugin to work with AWS)
```
    
5. Run in terminal: 
```zsh
    terraform plan (show what will be created)
```
    
6. After command: 
```zsh
    terraform apply 
```
You see confirmation question. When you confirm this action with "yes" terraform starts create on AWS resources

Also you can run:
```zsh
    terraform apply -auto-approve
```
This command will not ask any confirm, becouse of -auto-approve.

## Terraform variables

# Credentials aws

variable "access_key" {
     description = "Access key to AWS console"
     
}

variable "secret_key" {
     description = "Secret key to AWS console"
     
}


# Authorization via ssh key

variable "public_key_path" {
  description = "Public key path"
  default = "path to public key"
}

variable "server_port" {
  description = "The port the web server will be listening"
  type        = number
  default     = 8080
}

variable "ssh_server_port" {
  description = "The port to ssh server"
  type        = number
  default     = 22
}

variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type        = string
  default     = "web-test"
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The key name for SSH to the instance"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = ""
}


## Ansible 
Ansible start configure your server in automatic mode

Ansible contains some roles:
Role "java" - install java on server
Role "postgres" - install postgres DB on server, create role for jenkins user, sonarqube user.
Role "jenkins" - create user jenkis, group jenkins.

File "all_server.yml" - contains roles what will be run at server.
File "sonar.yml" - use role from Ansible Galaxy to install sonarqube.