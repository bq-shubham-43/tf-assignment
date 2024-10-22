module "vpc1" {
  source          = "./modules/vpc"
  vpc_name        = var.vpc1_name
  subnet_name     =var.vpc1_subnet_name
  subnet_ip_range = var.vpc1_subnet_ip_range
  reserved_subnet_ip_range = var.vpc1_reserved_subnet_ip_range # Reserved subnet range for internal load balancer
  allow_ports     = var.allow_ports
  region          =  var.region
}

module "vpc2" {
  source                   = "./modules/vpc"
  vpc_name                 = var.vpc2_name
  subnet_name              = var.vpc2_subnet_name
  subnet_ip_range          = var.vpc2_subnet_ip_range
  reserved_subnet_ip_range = var.vpc2_reserved_subnet_ip_range
  allow_ports              = var.allow_ports
  region                   = var.region
}

# MIG for VPC-1
module "mig_vpc1" {
  source              = "./modules/mig"
  instance_group_name = var.mig_vpc1_name
  vpc_name            = module.vpc1.vpc_name
  region              = var.region
  zone                = var.zone
  subnet_name         = module.vpc1.subnet_id 
}

# MIG for VPC-2
module "mig_vpc2" {
  source              = "./modules/mig"
  instance_group_name = var.mig_vpc2_name
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
# Internal Load Balancer for VPC 1
module "internal_lb_vpc1" {
  source              = "./modules/internal_lb"
  vpc_name            = module.vpc1.vpc_name
  vpc_id              = module.vpc1.vpc_self_link
  subnet_id           = module.vpc1.subnet_id
  reserved_subnet_ip_range = var.vpc1_reserved_subnet_ip_range
  region              = var.region
  instance_group_name = module.mig_vpc1.instance_group_self_link
}

# Internal Load Balancer for VPC 2
module "internal_lb_vpc2" {
  source              = "./modules/internal_lb"
  vpc_name            = module.vpc2.vpc_name
  vpc_id              = module.vpc2.vpc_self_link
  subnet_id           = module.vpc2.subnet_id
  reserved_subnet_ip_range = var.vpc2_reserved_subnet_ip_range
  region              = var.region
  instance_group_name = module.mig_vpc2.instance_group_self_link
}

# VPC Peering 
module "vpc_peering" {
  source         = "./modules/vpc_peering"
  vpc_1_name     = module.vpc1.vpc_name
  vpc_1_self_link = module.vpc1.vpc_self_link
  vpc_2_name     = module.vpc2.vpc_name
  vpc_2_self_link = module.vpc2.vpc_self_link
}
