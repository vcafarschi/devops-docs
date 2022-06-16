#!/bin/bash

db_pass=$(openssl rand -hex 8)
app_pass=$(openssl rand -hex 8)
keystore_pass=$(openssl rand -hex 8)

echo "db_pass: $db_pass" >> ./vars/extra_vars.yml
echo "app_pass: $app_pass" >>  ./vars/extra_vars.yml
echo "keystore_pass: $keystore_pass" >> ./vars/extra_vars.yml

