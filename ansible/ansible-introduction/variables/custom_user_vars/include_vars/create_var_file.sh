#!/bin/bash

touch dynamic_external_vars.yml

echo "lb_ip: 10.0.0.1" >> ./vars/dynamic_external_vars.yml
echo "lb_port: 32678" >>  ./vars/dynamic_external_vars.yml
