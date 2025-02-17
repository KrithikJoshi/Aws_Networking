provider "aws" {
  profile = "default"
  region = "ap-south-1"
}

resource "aws_vpc" "my_test_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  } 
}

resource "aws_subnet" "my_test_subnet" {
  cidr_block = var.subnet_cidr
  vpc_id = aws_vpc.my_test_vpc.id
  tags = {
    Name = var.subnet_name
  }

}

resource "aws_internet_gateway" "mytestigw" {
  vpc_id = aws_vpc.my_test_vpc.id

  tags = {
    Name = var.igw_name 
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mytestigw.id
  }
 tags = {
  Name = var.igw_name
 }
  
}

resource "aws_route_table_association" "public_1_rt_association" {
  subnet_id = aws_subnet.my_test_subnet.id
  route_table_id = aws_route_table.public_rt.id
  
}

resource "aws_security_group" "app_sg" {
  name = "HTTP"
  vpc_id = aws_vpc.my_test_vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_instance" "app_instance" {
  ami = var.ec2_ami
  instance_type = "t3.micro"

  subnet_id = aws_subnet.my_test_subnet.id
  vpc_security_group_ids = [ aws_security_group.app_sg.id ]
  associate_public_ip_address = true
  user_data = <<-EOF
  #!/bin/bash -ex

  amazon-linux-extras -y
  echo "<h1> This is my new server</h1>" /usr/share/nginx/html/index.html
  systemctl enable nginx
  systemctl start nginx
  EOF

  tags = {
    Name = var.ec2_name
  }
}