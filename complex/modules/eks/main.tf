data "aws_caller_identity" "current" {}

module "eks-cluster" {
  source           = "terraform-aws-modules/eks/aws"
  version          = "18.20.5"

  cluster_name     = var.cluster_name
  cluster_version  = var.kubernetes_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  # aws-auth configmap
  manage_aws_auth_configmap = true

  subnet_ids = var.private_subnets
  vpc_id  = var.vpc_id

  cluster_tags = {
    Name = var.cluster_name
  }

  cluster_addons = {
    coredns = {
      addon_version     = "v1.8.4-eksbuild.1"
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {
      addon_version     = "v1.21.2-eksbuild.2"
      resolve_conflicts = "OVERWRITE"
    }
    vpc-cni = {
      addon_version     = "v1.10.1-eksbuild.1"
      resolve_conflicts = "OVERWRITE"
    }
  }

  eks_managed_node_group_defaults = {
    ami_type                     = "AL2_x86_64"
    platform                     = "linux"
    instance_types               = var.asg_instance_types
    iam_role_attach_cni_policy   = true
    subnet_ids                   = var.private_subnets
    tags = {
      "k8s.io/cluster-autoscaler/${var.env}" = "owned"
      "k8s.io/cluster-autoscaler/enabled"    = true
    }
  }

  eks_managed_node_groups = {
    # Default node group - as provided by AWS EKS
    default_node_group = {
      # By default, the module creates a launch template to ensure tags are propagated to instances, etc.,
      # so we need to disable it to use the default template provided by the AWS EKS managed node group service
      create_launch_template = false
      launch_template_name   = ""

      desired_size                 = 1
      min_size                     = 0
      max_size                     = 2
      ebs_optimized                = true
      capacity_type                = "ON_DEMAND"

      block_device_mappings = {
        root = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size = 30
            volume_type = "gp3"
          }
        }
      }
    }

    dynamic_node_group = {
      # By default, the module creates a launch template to ensure tags are propagated to instances, etc.,
      # so we need to disable it to use the default template provided by the AWS EKS managed node group service
      create_launch_template = false
      launch_template_name   = ""

      desired_size                 = var.autoscaling_minimum_size_by_az
      min_size                     = var.autoscaling_minimum_size_by_az
      max_size                     = var.autoscaling_maximum_size_by_az
      ebs_optimized                = true
      capacity_type                = "SPOT"

      force_update_version         = true
      block_device_mappings = {
        root = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size = 20
            volume_type = "gp3"
            delete_on_termination = true
          }
        }
      }
    }
  }

  # map developer and admin ARNs as k8s users
  aws_auth_users = concat(local.admin_user_map_users, local.developer_user_map_users)
  aws_auth_roles = local.iam_role_nodes
}

resource "aws_iam_role_policy_attachment" "s3FullAccess" {
  depends_on = [module.eks-cluster]
  role       = module.eks-cluster.cluster_iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_eks_cluster" "default" {
  name = module.eks-cluster.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks-cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}

# # deploy spot termination handler
# resource "helm_release" "spot_termination_handler" {
#   name       = var.spot_termination_handler_chart_name
#   chart      = var.spot_termination_handler_chart_name
#   repository = var.spot_termination_handler_chart_repo
#   version    = var.spot_termination_handler_chart_version
#   namespace  = var.spot_termination_handler_chart_namespace
# }
