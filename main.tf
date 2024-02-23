terraform {
    required_providers {
      aws ={
        source = "hashicorp/aws"
      }
    }
}
provider "aws" {
    region = "ap-south-1"
    profile = "default"     
}
data "aws_ami" "tsubami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}
resource "aws_vpc" "tsubvpc" {
    cidr_block = var.vpccidr
    tags = {
      "Name" = "anithavpc"
    }
}
resource "aws_subnet" "tsub_pubsunet" {
    vpc_id = aws_vpc.tsubvpc.id
    cidr_block = var.sunetcidr
    tags = {
      "Name" = "anithapubsubnet"
    }
    availability_zone = "ap-south-1a"
}
resource "aws_internet_gateway" "tsubig" {
  vpc_id = aws_vpc.tsubvpc.id
  tags = {
    "Name" = "anithaig"
  }
}
resource "aws_route_table" "tsubrt" {
  vpc_id = aws_vpc.tsubvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tsubig.id
  }
}
resource "aws_route_table_association" "tsubrta" {
  subnet_id      = aws_subnet.tsub_pubsunet.id
  route_table_id = aws_route_table.tsubrt.id
}
resource "aws_security_group" "tsubsg" {
  vpc_id = aws_vpc.tsubvpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
   from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}
resource "aws_key_pair" "tsubkeypair" {
    key_name = "tsubkey"
    public_key = var.keypair
}
resource "aws_instance" "tsubec2" {
  subnet_id = aws_subnet.tsub_pubsunet.id
  security_groups = [ aws_security_group.tsubsg.id ]
  instance_type = var.instancetype
  ami = data.aws_ami.tsubami.id
  key_name = aws_key_pair.tsubkeypair.key_name
  availability_zone = "ap-south-1a"
  associate_public_ip_address = true
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = file("anitha")
  }
  provisioner "file" {
   source = "installjdk.sh"
   destination = "/home/ubuntu/installjdk.sh" 
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo chmod u+x /home/ubuntu/installjdk.sh",
      "sudo bash /home/ubuntu/installjdk.sh"
    ]
  }
}
