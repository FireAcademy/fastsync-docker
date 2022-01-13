#!/usr/bin/env bash

. /chia-blockchain/venv/bin/activate
chia stop all -d
cd /root/.chia/mainnet/db/
cp blockchain_v1_mainnet.sqlite /var/www/html/blockchain_v1_mainnet.sqlite.2
cd /var/www/html
mv blockchain_v1_mainnet.sqlite.2 blockchain_v1_mainnet.sqlite
chown -R www-data:www-data /var/www/html
chia start node
