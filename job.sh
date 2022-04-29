#!/usr/bin/env bash

. /chia-blockchain/venv/bin/activate
chia stop all

cd /root/.chia/mainnet/db/
test -f blockchain_v2_mainnet.sqlite && cp blockchain_v2_mainnet.sqlite /var/www/html/blockchain_v2_mainnet.sqlite.2
test -f blockchain_v2_testnet10.sqlite && cp blockchain_v2_testnet10.sqlite /var/www/html/blockchain_v2_testnet10.sqlite.2

cd /var/www/html
test -f blockchain_v2_mainnet.sqlite.2 && mv blockchain_v2_mainnet.sqlite.2 blockchain_v2_mainnet.sqlite
test -f blockchain_v2_testnet10.sqlite.2 && mv blockchain_v2_testnet10.sqlite.2 blockchain_v2_testnet10.sqlite

chown -R www-data:www-data /var/www/html
chia start node
