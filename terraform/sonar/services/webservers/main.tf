provider "aws" {
  region = "us-east-2"
}

module "webservers" {
  source        = "../../../modules/services/webservers"
  access_key    = ""
  secret_key    = ""
  cluster_name  = "web-prod"
  instance_type = "t2.micro"
  key_name      = ""
  user_data     = file("./files/user_data.sh")
  server_port   = 8080
  sonar_port    = 9000
}

