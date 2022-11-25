#!/usr/bin/env bash

. /chia-blockchain/venv/bin/activate

cd /root/.chia/mainnet/db/
test -f blockchain_v2_mainnet.sqlite && sqlite3 ./blockchain_v2_mainnet.sqlite "vacuum into '/var/www/html/blockchain_v2_mainnet.sqlite.bak'"
test -f blockchain_v2_testnet10.sqlite && sqlite3 ./blockchain_v2_testnet10.sqlite "vacuum into '/var/www/html/blockchain_v2_testnet10.sqlite.bak'"
test -f height-to-hash && cp height-to-hash /var/www/html/height-to-hash.bak

cd /var/www/html
chown www-data:www-data *
test -f blockchain_v2_mainnet.sqlite.bak && mv blockchain_v2_mainnet.sqlite.bak blockchain_v2_mainnet.sqlite
test -f blockchain_v2_testnet10.sqlite.bak && mv blockchain_v2_testnet10.sqlite.bak blockchain_v2_testnet10.sqlite
test -f height-to-hash.bak && mv height-to-hash.bak height-to-hash

chown -R www-data:www-data /var/www/html
