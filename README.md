# Terraform AWS Jumpbox

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Create a jumpbox in a public subnet which give RDP access to instances in private subnets.
This module should be used with [aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc) module.

# Run Terraform

  - Move to stacks Folder and Run below command for terraform Init
  *terraform init -input=false -backend=true -backend-config=bucket=<BucketName> -backend-config=key=<PathInS3>/jumpbox.tfstate -backend-config=region=<Region>*
  - Run Below Commands for Terraform Plan
  *terraform plan -no-color -out=tfplan -input=false -var-file="../environments/global.tfvars" -var-file="../environments/dev.tfvars"*
- Run Below commands for Terraform Apply
*terraform apply -input=false -no-color tfplan*
- Run below Commands if you wish to destroy the instances, first Plan
*terraform plan -destroy -no-color -out=tfplan -input=false -var-file="../environments/global.tfvars" -var-file="../environments/dev.tfvars"*
-Run Below command to destroy
*terraform apply -input=false -no-color tfplan*


Expected Output:

> MANISH-PC@DESKTOP-NEEJB63 MINGW64 /d/terraform-aws-jumpbox-master/terraform-aws-jumpbox-master/stacks
> $ terraform plan -no-color -out=tfplan -input=false -var-file="../environments/global.tfvars" -var-file="../environments/dev.tfvars"
> Refreshing Terraform state in-memory prior to plan...
> The refreshed state will be used to calculate this plan, but will not be
> persisted to local or remote state storage.
> 
> data.template_file.user_data: Refreshing state...
> data.aws_vpc.default: Refreshing state...
> data.aws_subnet.amber1: Refreshing state...
> data.aws_vpc.client_vpc: Refreshing state...
> data.aws_subnet.amber2: Refreshing state...
> data.aws_subnet.amber3: Refreshing state...
> 
> ------------------------------------------------------------------------
> 
> An execution plan has been generated and is shown below.
> Resource actions are indicated with the following symbols:
>   + create
> 
> Terraform will perform the following actions:
> 
>   # aws_eip.jump will be created
>   + resource "aws_eip" "jump" {
>       + allocation_id     = (known after apply)
>       + association_id    = (known after apply)
>       + customer_owned_ip = (known after apply)
>       + domain            = (known after apply)
>       + id                = (known after apply)
>       + instance          = (known after apply)
>       + network_interface = (known after apply)
>       + private_dns       = (known after apply)
>       + private_ip        = (known after apply)
>       + public_dns        = (known after apply)
>       + public_ip         = (known after apply)
>       + public_ipv4_pool  = (known after apply)
>       + tags              = {
>           + "Environment" = "dev"
>           + "Name"        = "JumpBoxEIP"
>           + "Owner"       = "manishparida123@hotmail.com"
>         }
>       + vpc               = true
>     }
> 
>   # aws_instance.jump will be created
>   + resource "aws_instance" "jump" {
>       + ami                          = "ami-0a0597b59c36af603"
>       + arn                          = (known after apply)
>       + associate_public_ip_address  = true
>       + availability_zone            = "ap-south-1a"
>       + cpu_core_count               = (known after apply)
>       + cpu_threads_per_core         = (known after apply)
>       + get_password_data            = false
>       + host_id                      = (known after apply)
>       + iam_instance_profile         = "EC2_Role"
>       + id                           = (known after apply)
>       + instance_state               = (known after apply)
>       + instance_type                = "t2.micro"
>       + ipv6_address_count           = (known after apply)
>       + ipv6_addresses               = (known after apply)
>       + key_name                     = "windows_key_pair"
>       + network_interface_id         = (known after apply)
>       + outpost_arn                  = (known after apply)
>       + password_data                = (known after apply)
>       + placement_group              = (known after apply)
>       + primary_network_interface_id = (known after apply)
>       + private_dns                  = (known after apply)
>       + private_ip                   = (known after apply)
>       + public_dns                   = (known after apply)
>       + public_ip                    = (known after apply)
>       + security_groups              = (known after apply)
>       + source_dest_check            = true
>       + subnet_id                    = "subnet-a42e2acc"
>       + tags                         = {
>           + "Environment" = "dev"
>           + "Name"        = "JumpBoxEC2"
>           + "Owner"       = "manishparida123@hotmail.com"
>         }
>       + tenancy                      = (known after apply)
>       + user_data                    = "75fd8f147975fe253796a8a7f3e30a9ebf0bb1c1"
>       + volume_tags                  = (known after apply)
>       + vpc_security_group_ids       = (known after apply)
> 
>       + ebs_block_device {
>           + delete_on_termination = (known after apply)
>           + device_name           = (known after apply)
>           + encrypted             = (known after apply)
>           + iops                  = (known after apply)
>           + kms_key_id            = (known after apply)
>           + snapshot_id           = (known after apply)
>           + volume_id             = (known after apply)
>           + volume_size           = (known after apply)
>           + volume_type           = (known after apply)
>         }
> 
>       + ephemeral_block_device {
>           + device_name  = (known after apply)
>           + no_device    = (known after apply)
>           + virtual_name = (known after apply)
>         }
> 
>       + metadata_options {
>           + http_endpoint               = (known after apply)
>           + http_put_response_hop_limit = (known after apply)
>           + http_tokens                 = (known after apply)
>         }
> 
>       + network_interface {
>           + delete_on_termination = (known after apply)
>           + device_index          = (known after apply)
>           + network_interface_id  = (known after apply)
>         }
> 
>       + root_block_device {
>           + delete_on_termination = true
>           + device_name           = (known after apply)
>           + encrypted             = (known after apply)
>           + iops                  = (known after apply)
>           + kms_key_id            = (known after apply)
>           + volume_id             = (known after apply)
>           + volume_size           = 50
>           + volume_type           = (known after apply)
>         }
>     }
> 
>   # aws_security_group.jump will be created
>   + resource "aws_security_group" "jump" {
>       + arn                    = (known after apply)
>       + description            = "Allow RDP to the jumpbox"
>       + egress                 = [
>           + {
>               + cidr_blocks      = [
>                   + "0.0.0.0/0",
>                 ]
>               + description      = ""
>               + from_port        = 0
>               + ipv6_cidr_blocks = []
>               + prefix_list_ids  = []
>               + protocol         = "-1"
>               + security_groups  = []
>               + self             = false
>               + to_port          = 0
>             },
>         ]
>       + id                     = (known after apply)
>       + ingress                = [
>           + {
>               + cidr_blocks      = [
>                   + "0.0.0.0/0",
>                 ]
>               + description      = ""
>               + from_port        = 3389
>               + ipv6_cidr_blocks = []
>               + prefix_list_ids  = []
>               + protocol         = "tcp"
>               + security_groups  = []
>               + self             = false
>               + to_port          = 3389
>             },
>         ]
>       + name                   = (known after apply)
>       + owner_id               = (known after apply)
>       + revoke_rules_on_delete = false
>       + tags                   = {
>           + "Environment" = "dev"
>           + "Name"        = "JumpBoxSG"
>           + "Owner"       = "manishparida123@hotmail.com"
>         }
>       + vpc_id                 = "vpc-52c3dc3a"
>     }
> 
> Plan: 3 to add, 0 to change, 0 to destroy.
> 
> ------------------------------------------------------------------------
> 
> This plan was saved to: tfplan
> 
> To perform exactly these actions, run the following command to apply:
>     terraform apply "tfplan"
> 
> 
> MANISH-PC@DESKTOP-NEEJB63 MINGW64 /d/terraform-aws-jumpbox-master/terraform-aws-jumpbox-master/stacks
> $ terraform apply -input=false -no-color tfplan
> aws_security_group.jump: Creating...
> aws_security_group.jump: Creation complete after 4s [id=sg-0a450895220daa38f]
> aws_instance.jump: Creating...
> aws_instance.jump: Still creating... [10s elapsed]
> aws_instance.jump: Still creating... [20s elapsed]
> aws_instance.jump: Still creating... [30s elapsed]
> aws_instance.jump: Creation complete after 35s [id=i-0006a5366a94556aa]
> aws_eip.jump: Creating...
> aws_eip.jump: Creation complete after 2s [id=eipalloc-0dd524ebf0c73b216]
> 
> Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
> 
> Outputs:
> 
> aws_eip_id = eipalloc-0dd524ebf0c73b216
> aws_eip_instance = i-0006a5366a94556aa
> aws_eip_network_interface = eni-0efbb924a718ae232
> aws_eip_private_dns = ip-172-31-37-197.ap-south-1.compute.internal
> aws_eip_private_ip = 172.31.37.197
> aws_eip_public_dns = ec2-3-6-50-230.ap-south-1.compute.amazonaws.com
> aws_eip_public_ip = 3.6.50.230
> aws_eip_public_ipv4_pool = amazon
> aws_instance_arn = arn:aws:ec2:ap-south-1:095972611389:instance/i-0006a5366a94556aa
> aws_instance_availability_zone = ap-south-1a
> aws_instance_credit_specification = [
>   {
>     "cpu_credits" = "standard"
>   },
> ]
> aws_instance_id = i-0006a5366a94556aa
> aws_instance_key_name = windows_key_pair
> aws_instance_password_data =
> aws_instance_placement_group =
> aws_instance_private_dns = ip-172-31-37-197.ap-south-1.compute.internal
> aws_instance_private_ip = 172.31.37.197
> aws_instance_public_dns = ec2-35-154-175-177.ap-south-1.compute.amazonaws.com
> aws_instance_public_ip = 35.154.175.177
> aws_instance_security_groups = [
>   "terraform-20201108164217774200000001",
> ]
> aws_instance_subnet_id = subnet-a42e2acc
> aws_instance_vpc_security_group_ids = [
>   "sg-0a450895220daa38f",
> ]
> aws_security_group_arn = arn:aws:ec2:ap-south-1:095972611389:security-group/sg-0a450895220daa38f
> aws_security_group_description = Allow RDP to the jumpbox
> aws_security_group_egress = [
>   {
>     "cidr_blocks" = [
>       "0.0.0.0/0",
>     ]
>     "description" = ""
>     "from_port" = 0
>     "ipv6_cidr_blocks" = []
>     "prefix_list_ids" = []
>     "protocol" = "-1"
>     "security_groups" = []
>     "self" = false
>     "to_port" = 0
>   },
> ]
> aws_security_group_id = sg-0a450895220daa38f
> aws_security_group_ingress = [
>  {
>     "cidr_blocks" = [
>       "0.0.0.0/0",
>     ]
>     "description" = ""
>     "from_port" = 3389
>     "ipv6_cidr_blocks" = []
>     "prefix_list_ids" = []
>     "protocol" = "tcp"
>     "security_groups" = []
>     "self" = false
>     "to_port" = 3389
>   },
> ]
> aws_security_group_name = terraform-20201108164217774200000001
> aws_security_group_owner_id = 095972611389
> aws_security_group_vpc_id = vpc-52c3dc3a