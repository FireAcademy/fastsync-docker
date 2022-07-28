#!/usr/bin/env bash

. /chia-blockchain/venv/bin/activate

cd /root/.chia/mainnet/db/
test -f blockchain_v2_mainnet.sqlite && sqlite3 ./blockchain_v2_mainnet.sqlite "vacuum into '/var/www/html/blockchain_v2_mainnet.sqlite.bak'"
test -f blockchain_v2_testnet10.sqlite && sqlite3 ./blockchain_v2_testnet10.sqlite "vacuum into '/var/www/html/blockchain_v2_testnet10.sqlite.bak'"

cd /var/www/html
test -f blockchain_v2_mainnet.sqlite.bak && mv blockchain_v2_mainnet.sqlite.2 blockchain_v2_mainnet.sqlite
test -f blockchain_v2_testnet10.sqlite.bak && mv blockchain_v2_testnet10.sqlite.2 blockchain_v2_testnet10.sqlite

chown -R www-data:www-data /var/www/html
