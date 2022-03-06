#!/bin/bash

consul agent --config-file=/scripts/ingress-gw-1.hcl &

consul connect envoy -gateway=ingress -register -service route-based-ingress \
   -admin-bind="0.0.0.0:19000" -address '{{ GetInterfaceIP "eth0" }}:8888' &

consul connect envoy -gateway=ingress -register -service host-based-ingress \
   -admin-bind="0.0.0.0:19001" -address '{{ GetInterfaceIP "eth0" }}:8889'