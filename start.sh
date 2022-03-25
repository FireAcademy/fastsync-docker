# there's no need to start the wallet
chia stop all

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