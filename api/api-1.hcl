node_name = "api"
server = false
datacenter = "dc1"
data_dir = "/consul/data"
log_level = "INFO"
retry_join = [
  "consul"
]
// enable_syslog = true
// enable_central_service_config = true
// enable_script_checks = true
// node_meta {
//    java-version = "No default java",
//    server-type = "application",
//    cluster-type = "common",
//    patch-set = "2021Q4"
// }
// ports {  "grpc" = 8502  }

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
