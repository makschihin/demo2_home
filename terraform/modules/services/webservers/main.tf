#############################################################################
# Region in which we are creating infrastructure
#############################################################################
provider "aws" {
  region = "us-east-2"
  default_tags {
   tags = {
     ita_group = "Dp_206"
   }
 }
}

#############################################################################
# Configuration for new instance
#############################################################################
resource "aws_instance" "ubuntu_instance" {
  ami                    = "ami-0b9064170e32bde34"
  subnet_id              = aws_subnet.demo2-public-1.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.http.id, aws_security_group.ssh.id]
  key_name               = aws_key_pair.ec2key.key_name
  user_data              = var.user_data
  tags = {
    Name      = "${var.cluster_name}"

  }
}

#############################################################################
# Security group server (http listen port)
#############################################################################
resource "aws_security_group" "http" {
  name = "${var.cluster_name}-http-sg"
  vpc_id = aws_vpc.demo2-vpc.id
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#############################################################################
# Security group server (ssh listen port)
#############################################################################
resource "aws_security_group" "ssh" {
  name = "${var.cluster_name}-ssh-sg"
  vpc_id = aws_vpc.demo2-vpc.id
  ingress {
    from_port   = var.ssh_server_port
    to_port     = var.ssh_server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#############################################################################
# Create VPC
#############################################################################
resource "aws_vpc" "demo2-vpc" {
    cidr_block           = "172.16.0.0/16"
    enable_dns_support   = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #gives you an internal host name
    enable_classiclink   = "false"
    instance_tenancy     = "default"    
    
    tags = {
        Name = "demo2-vpc"
        ita_group = "Dp_206"
    }
}

#############################################################################
# Create Public subnet
#############################################################################
resource "aws_subnet" "demo2-public-1" {
    vpc_id = aws_vpc.demo2-vpc.id
    cidr_block = "172.16.1.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "us-east-2a"

    tags = {
        Name = "demo2-public-1"
        ita_group = "Dp_206"
    }
}

#############################################################################
# Create Internet Gateway
#############################################################################
resource "aws_internet_gateway" "demo2-igw" {
    vpc_id = aws_vpc.demo2-vpc.id

    tags = {
        Name = "demo2-igw"
        ita_group = "Dp_206"
    }
}

#############################################################################
# Create Route Table
#############################################################################
resource "aws_route_table" "demo2-public-crt" {
    vpc_id = aws_vpc.demo2-vpc.id
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = aws_internet_gateway.demo2-igw.id
      }
    
    tags = {
        Name = "demo2-public-crt"
        ita_group = "Dp_206"
    }
}

#############################################################################
# Assosiate Subnet with Route Table
#############################################################################
resource "aws_route_table_association" "demo2-crta-public-subnet-1"{
    subnet_id = aws_subnet.demo2-public-1.id
    route_table_id = aws_route_table.demo2-public-crt.id
}

#############################
# Create ssh key
#############################
resource "aws_key_pair" "ec2key" {
  key_name = "publicKey"
  public_key = file(var.public_key_path)

}