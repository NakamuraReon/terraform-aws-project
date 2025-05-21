# VPC モジュール
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "main-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-northeast-1a"]
  public_subnets  = ["10.0.1.0/24"]
  enable_nat_gateway = false
  enable_dns_hostnames = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

# EC2 インスタンスモジュール
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  name           = "example-instance"
  ami            = "ami-0c3fd0f5d33134a76"
  instance_type  = "t2.micro"
  subnet_id      = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids = [module.vpc.default_security_group_id]

  tags = {
    Name = "example-instance"
  }
}
