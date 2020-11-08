##################
# Security group #
##################
variable "aws_security_group_cidr_blocks" {
  description = "List of CIDR to allow RDP from"
  type        = list
}



############
# Instance #
############
variable "aws_instance_instance_type" {
  description = "The type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance"
  default     = "t2.micro"
}

variable "aws_instance_ami" {
  description = "The AMI to use for the instance"
}

variable "aws_instance_key_name" {
  description = "The key name of the Key Pair to use for the instance"
}

variable "aws_instance_volume_size" {
  description = "The size of the volume in gibibytes (GiB)"
  type        = string
  default     = "50"
}

variable "team_deployer_role" 					        {}
variable "delete_on_termination" 				        {}
variable "availability_zone" 		    		        {}
variable "aws_region" 							            {}
variable "aws_account"							            {}
variable "app_profile_name"						          {}
variable "vpc_name"								              {}
variable "amber_a"                              {}
variable "amber_b"                              {}
variable "amber_c"                              {}