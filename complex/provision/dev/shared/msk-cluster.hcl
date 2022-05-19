skip = true

dependency "msk" {
  config_path = "${get_original_terragrunt_dir()}/../msk"
  mock_outputs = {
    kafka_bootstrap_broker_tls = "kafka_bootstrap_broker_tls"
    zookeeper_connect_string = "zookeeper_connect_string"
  }
}
