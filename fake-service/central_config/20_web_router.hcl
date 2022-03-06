Kind = "service-router"
Name = "web-router"

Routes = [
 {
   Match {
     HTTP {
       PathPrefix = "/api"
     }
   }
   Destination {
     Service = "api"
   }
 },
 {
   Match {
     HTTP {
       PathPrefix = "/web"
     }
   }
   Destination {
     Service = "web"
   }
 },
 {
   Match {
     HTTP {
       PathPrefix = "/"
     }
   }
   Destination {
     Service = "ingress"
   }
 },
]

