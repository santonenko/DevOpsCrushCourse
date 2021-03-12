provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "jenkins_server" {
    ami = "ami-0767046d1677be5a0" # ubuntu
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.jenkins_server.id]
    user_data = file("jenkinsInstall.sh")
    key_name = "aws_key"    
    
    tags = {
        Name: "jenkins server by terraform"
    }
}

resource "aws_security_group" "jenkins_server" {
  name        = "jenkins server security group"
  description = "jenkins secutiry group"

  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins server security group"
  }
}
