aws_region                           = "ap-south-1"
team_deployer_role                   = "EC2_Role"
amber_a                              = "amber-1"
amber_b                              = "amber-2"

#=================EC2=========================
aws_instance_volume_size	         = "50"
aws_instance_key_name                = "windows_key_pair"
delete_on_termination                = "true"
aws_instance_ami                     = "ami-0a0597b59c36af603"
aws_security_group_cidr_blocks       = ["0.0.0.0/0"]