node_name = "consul-server"
server = true
bootstrap = true
datacenter = "dc1"
data_dir = "/consul/data"
log_level = "INFO"

addresses {
  http = "0.0.0.0"
}

ui_config {
  enabled = true
}

ports {
  dns = 8600
  grpc = 8502
}

connect {
  enabled = true
}

telemetry {
  prometheus_retention_time = "60s"
  disable_hostname = true
}

service {
  id = "dns"
  name = "dns"
  tags = ["primary"]
  address = "localhost"
  port = 8600
  enable_tag_override = false

  check {
    id = "dns"
    name = "Consul DNS TCP on port 8600"
    tcp = "localhost:8600"
    interval = "10s"
    timeout = "1s"
  }
}
