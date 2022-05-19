locals {
  log_group_name = "${var.env}-msk-broker-logs"

  log_bucket = "app.domain.${var.env}.msk-broker-logs-bucket"

  firehore_role = "${var.env}-firehose-test-role"

  kinesis_name = "${var.env}-kinesis-firehose-msk-broker-logs-stream"
}
