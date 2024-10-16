module "vpc1" {
  source          = "./modules/vpc"
  vpc_name        = "vpc-network-1"
  subnet_name     = "subnet-1"
  subnet_ip_range = "10.0.1.0/24"
  reserved_subnet_ip_range = "192.168.1.0/24" # Reserved subnet range for internal load balancer
  allow_ports     = ["80", "443"]
  region          = "us-central1"
}

module "vpc2" {
  source          = "./modules/vpc"
  vpc_name        = "vpc-network-2"
  subnet_name     = "subnet-2"
  subnet_ip_range = "10.0.2.0/24"
  reserved_subnet_ip_range = "192.168.2.0/24" # Reserved subnet range for internal load balancer
  allow_ports     = ["80", "443"]
  region          = "us-central1"
}

# MIG for VPC-1
module "mig_vpc1" {
  source              = "./modules/mig"
  instance_group_name = "mig-instance-group-1"
  vpc_name            = module.vpc1.vpc_name
  region              = var.region
  zone                = var.zone
  subnet_name         = module.vpc1.subnet_id 
}

# MIG for VPC-2
module "mig_vpc2" {
  source              = "./modules/mig"
  instance_group_name = "mig-instance-group-2"
  vpc_name            = module.vpc2.vpc_name
  region              = var.region
  zone                = var.zone
  subnet_name         = module.vpc2.subnet_id 
}


# HTTP Load Balancer
module "http_lb" {
  source         = "./modules/http_lb"
  region         = var.region
  mig1_self_link = module.mig_vpc1.instance_group_self_link  # First MIG
  mig2_self_link = module.mig_vpc2.instance_group_self_link  # Second MIG
}