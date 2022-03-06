Kind = "ingress-gateway"
Name = "host-based-ingress"

TLS {
  Enabled = true
}

Listeners = [
  {
    Port = 8443
    Protocol = "http"
    Services = [
      {
        Name = "api"
        Hosts = ["api.ingress.container.local"]
      },
      {
        Name = "web"
        Hosts = ["web.ingress.container.local"]
      }
    ]
  }
]