output "bastion_public_ip" { 
  value = module.ec2.bastion_public_ip
}

output "private_private_ip" {
  value = module.ec2.private_private_ip
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}
