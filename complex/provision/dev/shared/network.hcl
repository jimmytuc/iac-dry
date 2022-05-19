skip = true

dependency "network" {
  config_path = "${get_original_terragrunt_dir()}/../network"

  mock_outputs = {
    cluster_name = "cluster-name"
    vpc_id = "vpc-00000000"
    private_subnets = [
      "subnet-00000000",
      "subnet-00000001",
      "subnet-00000002",
    ]
    public_subnets = [
      "subnet-00000003",
      "subnet-00000004",
      "subnet-00000005",
    ]
    database_subnets = [
      "subnet-00000006",
      "subnet-00000007",
      "subnet-00000008",
    ]
    intra_subnets = [
      "subnet-00000009",
      "subnet-00000010",
      "subnet-00000011",
    ]
    elasticache_subnets = [
      "subnet-00000012",
      "subnet-00000013",
      "subnet-00000014",
    ]
    database_subnet_group_name = "db-subnet"
  }
}
