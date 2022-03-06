data_dir = "/consul/data"

telemetry {
  prometheus_retention_time = "60s"
  disable_hostname = true
}

log_level = "TRACE"
datacenter = "dc1"
server = true
bootstrap_expect = 1
bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"

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

advertise_addr = "10.5.0.2"
// enable_central_service_config = true

config_entries {
  bootstrap = [
    {
      kind = "proxy-defaults"
      name = "global"
      
      config {
        // envoy_prometheus_bind_addr = "0.0.0.0:9102"

        envoy_extra_static_clusters_json = <<EOL
          {
            "connect_timeout": "3.000s",
            "dns_lookup_family": "V4_ONLY",
            "lb_policy": "ROUND_ROBIN",
            "load_assignment": {
                "cluster_name": "zipkin",
                "endpoints": [
                    {
                        "lb_endpoints": [
                            {
                                "endpoint": {
                                    "address": {
                                        "socket_address": {
                                            "address": "10.5.0.9",
                                            "port_value": 9411,
                                            "protocol": "TCP"
                                        }
                                    }
                                }
                            }
                        ]
                    }
                ]
            },
            "name": "zipkin",
            "type": "STRICT_DNS"
          }
        EOL

        envoy_tracing_json = <<EOL
          {
            "http": {
              "name": "envoy.tracers.zipkin",
              "typedConfig": {
                "@type": "type.googleapis.com/envoy.config.trace.v3.ZipkinConfig",
                "collector_cluster": "zipkin",
                "collector_endpoint_version": "HTTP_JSON",
                "collector_endpoint": "/api/v1/spans",
                "shared_span_context": false
              }
            }
          }
        EOL
      }
    }
  ]
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
