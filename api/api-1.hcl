node_name = "api"
server = false
datacenter = "dc1"
data_dir = "/consul/data"
log_level = "INFO"
retry_join = [
  "consul-server"
]

service {
  id = "api-v1"
  name = "api"
  address = "10.5.0.5"
  port = 9090
  
  connect { 
    sidecar_service {
      port = 20000
      
      check {
        name = "Connect Envoy Sidecar"
        tcp = "10.5.0.5:20000"
        interval ="10s"
      }

      proxy {
      }
    }  
  }
}
