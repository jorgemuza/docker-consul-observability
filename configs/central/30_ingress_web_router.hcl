Kind = "ingress-gateway"
Name = "route-based-ingress"

TLS {
  Enabled = false
}

Listeners = [
 {
   Port = 8080
   Protocol = "http"
   Services = [
     {
       Name = "web-router"
       Hosts = [
         "*"
       ]
     }
   ]
 }
]

// consul connect envoy -gateway=ingress -register -service route-based-ingress -admin-bind="0.0.0.0:19001" -address '{{ GetInterfaceIP "eth0" }}:8889'
