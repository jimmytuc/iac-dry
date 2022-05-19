skip = true

dependency "s3" {
  config_path = "${get_original_terragrunt_dir()}/../s3"
  mock_outputs = {
    id = "s3-id"
    arn = "s3-arn"
  }
}
