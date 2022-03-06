Kind = "service-resolver"
Name = "web-router"

Redirect {
    Service = "web-router"
    Datacenter = "dc1"
}
