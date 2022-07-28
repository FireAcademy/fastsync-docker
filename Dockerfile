FROM ghcr.io/chia-network/chia:1.5.0

ENV service="node"
ENV upnp="false"
ENV healthcheck="false"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    cron apache2 apache2-utils

RUN chown -R www-data:www-data /var/www/html

COPY job.sh /
COPY crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab && \
    crontab /etc/cron.d/crontab

COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

CMD ["start.sh"]
