#!/usr/bin/env bash

chia stop all -d
cp /root/.chia/mainnet/db/blockchain_v1_mainnet.sqlite /var/www/html
chown -R www-data:www-data /var/www/html
chia start node