#!/usr/bin/env bash

. /chia-blockchain/venv/bin/activate
chia stop all -d
cd /root/.chia/mainnet/db/
zip -9 -r blockchain_v1_mainnet.sqlite.zip.2 blockchain_v1_mainnet.sqlite
mv blockchain_v1_mainnet.sqlite.zip.2 /var/www/html
cd /var/www/html
mv blockchain_v1_mainnet.sqlite.zip.2 blockchain_v1_mainnet.sqlite.zip
chown -R www-data:www-data /var/www/html
chia start node
