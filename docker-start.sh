#!/usr/bin/env bash

# shellcheck disable=SC2154
if [[ ${farmer} == 'true' ]]; then
  chia start farmer-only
elif [[ ${harvester} == 'true' ]]; then
  if [[ -z ${farmer_address} || -z ${farmer_port} || -z ${ca} ]]; then
    echo "A farmer peer address, port, and ca path are required."
    exit
  else
    chia start harvester
  fi
else
  chia start farmer
fi

trap "echo Shutting down ...; chia stop all -d; exit 0" SIGINT SIGTERM

if [[ ${log_to_file} == 'true' ]]; then
  # Ensures the log file actually exists, so we can tail successfully
  touch "$CHIA_ROOT/log/debug.log"
  tail -F "$CHIA_ROOT/log/debug.log" &
fi

# there's no need to start the wallet
chia stop all -d

# start web server
touch /var/www/html/blockchain_v2_mainnet.sqlite
service apache2 start

# sync
mkdir -p "$CHIA_ROOT/db"
cp /var/www/html/blockchain_v2_mainnet.sqlite "$CHIA_ROOT/db/"

# cron
service cron start

# start chia node
chia start node

while true; do sleep 1; done
