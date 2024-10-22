variable "project_id" {
  description = "The ID of the project."
  type        = string
}

variable "region" {
  description = "The region for the resources."
  type        = string
}

variable "zone" {
  description = "The zone for the resources."
  type        = string
}

# VPC-related variables
variable "vpc1_name" {
  description = "name of VPC 1"
  type        = string
}

variable "vpc2_name" {
  description = "name of VPC 2"
  type        = string
}

variable "vpc1_subnet_name" {
  description = "name of subnet for VPC 1"
  type        = string
}

variable "vpc2_subnet_name" {
  description = "name of subnet for VPC 2"
  type        = string
}

variable "vpc1_subnet_ip_range" {
  description = "CIDR for subnet in VPC 1"
  type        = string
}

variable "vpc2_subnet_ip_range" {
  description = " CIDR for subnet in VPC 2"
  type        = string
}

variable "vpc1_reserved_subnet_ip_range" {
  description = "Reserved subnet range for internal lb in VPC 1"
  type        = string
}

variable "vpc2_reserved_subnet_ip_range" {
  description = "Reserved subnet range for internal lb in VPC 2"
  type        = string
}

# MIG-related variables
variable "mig_vpc1_name" {
  description = " name of instance group for VPC 1"
  type        = string
}

variable "mig_vpc2_name" {
  description = "name of instance group for VPC 2"
  type        = string
}

# Load balancer-related variables
variable "allow_ports" {
  description = "allowed ports for  VPC firewall rules"
  type        = list(string)
}

variable "region" {
  description = "region to deploy resources"
  type        = string
}

variable "zone" {
  description = "Zone to deploy instances"
  type        = string
}

