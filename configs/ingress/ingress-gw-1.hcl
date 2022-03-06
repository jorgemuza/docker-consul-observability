node_name = "ingress"
server = false
datacenter = "dc1"
data_dir = "/consul/data"
log_level = "INFO"
retry_join = [
  "consul"
]