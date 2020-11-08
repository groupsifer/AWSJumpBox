terraform {
    backend "s3" {}
}

provider "aws" {
    version         = "~> 2.7"
    region          = var.aws_region
    assume_role {
        role_arn = "arn:aws:iam::${var.aws_account}:role/${var.team_deployer_role}"
    }
}

data "aws_vpc" "client_vpc" {
    filter {
        name    = "tag:Name"
        values     = ["${var.vpc_name}"]
    }
    state         = "available"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "amber1" {
  filter {
    name   = "tag:Name"
    values = ["${var.amber_a}"]
  }
}

data "aws_subnet" "amber2" {
  filter {
    name   = "tag:Name"
    values = ["${var.amber_b}"]
  }
}
data "aws_subnet" "amber3" {
  filter {
    name   = "tag:Name"
    values = ["${var.amber_c}"]
  }
}

resource "aws_security_group" "jump" {
  description = "Allow RDP to the jumpbox"
  vpc_id      = data.aws_vpc.client_vpc.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    cidr_blocks = var.aws_security_group_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Owner       = "manishparida123@hotmail.com"
    Name        = "JumpBoxSG"
    Environment = "dev"
  }
}

#___________________________________userdata___________________________________________________
data "template_file" "user_data" {
  template = "${file("user_data.tpl")}"
}

resource "aws_instance" "jump" {
  ami                         = var.aws_instance_ami
  instance_type               = var.aws_instance_instance_type
  key_name                    = var.aws_instance_key_name
  iam_instance_profile        = var.app_profile_name
  vpc_security_group_ids      = [aws_security_group.jump.id]
  subnet_id                   = data.aws_subnet.amber2.id #["${data.aws_subnet.amber1.id}","${data.aws_subnet.amber2.id}","${data.aws_subnet.amber3.id}"]
  availability_zone           = var.availability_zone
   user_data                  = data.template_file.user_data.rendered
  associate_public_ip_address = true
  
  root_block_device {
    volume_size = var.aws_instance_volume_size
    delete_on_termination = var.delete_on_termination
  }

  tags = {
    Owner       = "manishparida123@hotmail.com"
    Name        = "JumpBoxEC2"
    Environment = "dev"
  }
}

resource "aws_eip" "jump" {
  instance = aws_instance.jump.id
  vpc      = true
  
  tags = {
    Owner       = "manishparida123@hotmail.com"
    Name        = "JumpBoxEIP"
    Environment = "dev"
  }
}
