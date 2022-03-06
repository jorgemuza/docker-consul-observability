#!/bin/bash

consul connect envoy -gateway=ingress -register -service main-ingress \
   -admin-bind="0.0.0.0:19000" -address '{{ GetInterfaceIP "eth0" }}:8888'
