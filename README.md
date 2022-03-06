# Fetch root cert

The public endpoint for the Gateway has been configured to use a `TLS` certificate. In order to validate the requests
you need to obtain the `root` certicicate. This can be retrieved from Consul using the following API call.

```
curl -s http://127.0.0.1:8500/v1/connect/ca/roots | jq -r '.Roots[0].RootCert' > root.cert
```

# Gateway Client Certificate

You can inspect the client certificate which has been configured on the Gateway using the following command. If you look at the
`X509v3 Subject Alternative Name` section you will see that Consul has added the `Hosts` defined in the Listener configuration.

```shell
echo | openssl s_client -showcerts -servername web.ingress.container.local -connect web.ingress.container.local 2>/dev/null | openssl x509 -inform pem -noout -text  
```

```shell
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 12 (0xc)
        Signature Algorithm: ecdsa-with-SHA256
        Issuer: CN = pri-1hw6eku.consul.ca.b1eddb34.consul
        Validity
            Not Before: Jun  7 10:01:57 2020 GMT
            Not After : Jun 10 10:01:57 2020 GMT
        Subject: CN = ingressservice.svc.default.b1eddb34.consul
        Subject Public Key Info:
            Public Key Algorithm: id-ecPublicKey
                Public-Key: (256 bit)
                pub:
                    04:e2:7f:4b:d6:a0:d9:de:c7:4f:9f:09:2f:7a:22:
                    60:2a:ce:2c:c5:ba:88:11:8a:66:9f:80:50:7f:40:
                    52:1c:0f:15:de:23:fc:03:38:41:47:6b:8f:0c:47:
                    d4:ba:e0:28:c7:62:30:1a:ce:79:96:f4:27:52:81:
                    12:43:1e:37:72
                ASN1 OID: prime256v1
                NIST CURVE: P-256
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment, Data Encipherment, Key Agreement
            X509v3 Extended Key Usage: 
                TLS Web Client Authentication, TLS Web Server Authentication
            X509v3 Basic Constraints: critical
                CA:FALSE
            X509v3 Subject Key Identifier: 
                49:C2:3C:B4:B6:75:3A:5F:6F:5D:4A:DC:68:B8:14:37:2D:65:62:86:9D:0F:28:06:4D:C1:BF:CD:AB:E2:E8:A0
            X509v3 Authority Key Identifier: 
                keyid:07:19:20:58:4C:D2:2A:89:5B:00:72:F5:45:2D:6B:56:BB:64:F1:AF:DF:81:6F:81:89:3F:AA:1F:4C:2B:8A:60

            X509v3 Subject Alternative Name: 
                DNS:*.ingress.consul., DNS:*.ingress.dc1.consul., DNS:api.ingress.container.local, DNS:web.ingress.container.local, URI:spiffe://b1eddb34-f2af-f8ab-bd64-bc44fb9d4392.consul/ns/default/dc/dc1/svc/ingress-service
    Signature Algorithm: ecdsa-with-SHA256
         30:45:02:21:00:fd:22:d1:86:6c:cd:e3:9b:c4:34:d5:ab:4b:
         1f:79:90:3f:be:72:27:96:03:34:06:01:ce:d5:b0:42:e5:7d:
         18:02:20:04:49:4d:94:e7:8b:df:5c:cc:c5:b4:d6:2a:24:fa:
         22:d2:28:ba:a2:d2:46:a9:bd:1d:64:9c:e5:75:7d:57:1f
```

# Testing the setup

The example application has the DNS names `web.ingress.container.local` and `api.ingress.container.local` set to point to the 
ingress container `ingres.container.local`.

The ingress will use Host header matching to determine which upstream should be routed. You can test the setup using the following commands:

## Web
```
curl -v --cacert ./root.cert  https://web.ingress.container.local
```

## API
```
curl -v --cacert ./root.cert  https://web.ingress.container.local
```
