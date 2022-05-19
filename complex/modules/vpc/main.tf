# get all available AZs in our region
data "aws_availability_zones" "available_azs" {
  state = "available"
  exclude_names = var.exclude_availability_zones
}

# create VPC using the official AWS module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = "${var.name_prefix}-vpc"
  cidr = var.cidr
  azs  = data.aws_availability_zones.available_azs.names

  private_subnets = [
    # this loop will create a one-line list as ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20", ...]
    # with a length depending on how many AZs are available
    for zone_id in data.aws_availability_zones.available_azs.zone_ids :
    cidrsubnet(var.cidr, var.subnet_prefix_extension, tonumber(substr(zone_id, length(zone_id) - 1, 1)) - 1)
  ]

  public_subnets = [
    # this loop will create a one-line list as ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20", ...]
    # with a length depending on how many AZs are available
    # there is a zone offset variable, to make sure no collisions are present with private subnets
    for zone_id in data.aws_availability_zones.available_azs.zone_ids :
    cidrsubnet(var.cidr, var.subnet_prefix_extension, tonumber(substr(zone_id, length(zone_id) - 1, 1)) + var.zone_offset - 1)
  ]

  # database
  database_subnets = [
    # this loop will create a one-line list as ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20", ...]
    # with a length depending on how many AZs are available
    # there is a zone offset variable, to make sure no collisions are present with private subnets
    for zone_id in data.aws_availability_zones.available_azs.zone_ids :
    cidrsubnet(var.cidr, var.subnet_prefix_extension, tonumber(substr(zone_id, length(zone_id) - 1, 1)) + (var.zone_offset * 2) - 1)
  ]

  #
  elasticache_subnets = [
    # this loop will create a one-line list as ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20", ...]
    # with a length depending on how many AZs are available
    # there is a zone offset variable, to make sure no collisions are present with private subnets
    for zone_id in data.aws_availability_zones.available_azs.zone_ids :
    cidrsubnet(var.cidr, var.subnet_prefix_extension, tonumber(substr(zone_id, length(zone_id) - 1, 1)) + (var.zone_offset * 3) - 1)
  ]

  # intra subnets have no internet routing - reserved for future use.
  intra_subnets = [
    # this loop will create a one-line list as ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20", ...]
    # with a length depending on how many AZs are available
    # there is a zone offset variable, to make sure no collisions are present with private subnets
    for zone_id in data.aws_availability_zones.available_azs.zone_ids :
    cidrsubnet(var.cidr, var.subnet_prefix_extension, tonumber(substr(zone_id, length(zone_id) - 1, 1)) + (var.zone_offset * 4) - 1)
  ]

  # create a NAT gateway
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_dns_hostnames   = true

  # add VPC/Subnet tags required by EKS
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    iac_environment                             = var.iac_environment_tag
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
    iac_environment                             = var.iac_environment_tag
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
    iac_environment                             = var.iac_environment_tag
  }
}
