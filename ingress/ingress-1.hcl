node_name = "ingress"
server = false
datacenter = "dc1"
data_dir = "/consul/data"
log_level = "TRACE"
retry_join = [
  "consul"
]

service {
  id = "ingress-v1"
  name = "ingress"
  address = "10.5.0.3"
  port = 9090
  
  connect { 
    sidecar_service {
      port = 20000
      
      check {
        name = "Connect Envoy Sidecar"
        tcp = "10.5.0.3:20000"
        interval ="10s"
      }

      proxy {
        upstreams {
          destination_name = "web"
          local_bind_address = "127.0.0.1"
          local_bind_port = 9091
        }
      }
    }  
  }
}
