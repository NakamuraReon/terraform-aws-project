output "instance_public_ip" {
  value = module.ec2_instance.public_ip
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
