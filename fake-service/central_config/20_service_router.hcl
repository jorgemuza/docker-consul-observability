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
]

