project_id = "versatile-nomad-438205-q7"
region     = "us-central1"
zone       = "us-central1-a"

# VPC 1 details
vpc1_name = "vpc-network-1"
vpc1_subnet_name = "subnet-1"
vpc1_subnet_ip_range = "10.0.1.0/24"
vpc1_reserved_subnet_ip_range = "192.168.1.0/24"

# VPC 2 details
vpc2_name = "vpc-network-2"
vpc2_subnet_name = "subnet-2"
vpc2_subnet_ip_range = "10.0.2.0/24"
vpc2_reserved_subnet_ip_range = "192.168.2.0/24"

# MIG instance group names
mig_vpc1_name = "mig-instance-group-1"
mig_vpc2_name = "mig-instance-group-2"


allow_ports = ["80", "443"]