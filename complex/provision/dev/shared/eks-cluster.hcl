skip = true

dependency "eks" {
  config_path = "${get_original_terragrunt_dir()}/../eks-cluster"
  mock_outputs = {
    eks_host           = "https://sample-cluster"
    eks_ca_certificate = ""
    eks_token          = ""
    worker_security_group_id = "sg-"
    cluster_security_group_id = "sg-1a2a3a"
  }

  mock_outputs_merge_with_state = true
  mock_outputs_allowed_terraform_commands = ["validate", "fmt", "plan"]
}
