include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  name       = "${include.root.locals.environment}-queue"
  fifo_queue = true
}

terraform {
  source = "../../..//modules/sqs"
}
