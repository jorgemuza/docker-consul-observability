node_name = "web"
server = false
datacenter = "dc1"
data_dir = "/consul/data"
log_level = "INFO"
retry_join = [
  "consul"
]

service {
  name = "web"
  id = "web-v1"
  address = "10.5.0.4"
  port = 9090

  connect { 
    sidecar_service {
      port = 20000
      
      check {
        name = "Connect Envoy Sidecar"
        tcp = "10.5.0.4:20000"
        interval ="10s"
      }

      proxy {
        upstreams {
          destination_name = "api"
          local_bind_address = "127.0.0.1"
          local_bind_port = 9091
        }
      }
    }  
  }
}
