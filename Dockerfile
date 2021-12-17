FROM ubuntu:latest

EXPOSE 8444

ENV CHIA_ROOT=/root/.chia/mainnet
ENV keys="generate"
ENV harvester="false"
ENV farmer="false"
ENV plots_dir="/plots"
ENV farmer_address=
ENV farmer_port=
ENV testnet="false"
ENV TZ="UTC"
ENV upnp="true"
ENV log_to_file="true"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y bc curl lsb-release python3 tar bash ca-certificates git openssl unzip wget python3-pip sudo acl build-essential python3-dev python3.8-venv python3.8-distutils python-is-python3 vim tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime && echo "$TZ" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

ARG BRANCH=latest

RUN echo "cloning ${BRANCH}" && \
    git clone --branch ${BRANCH} https://github.com/Chia-Network/chia-blockchain.git && \
    cd chia-blockchain && \
    git submodule update --init mozilla-ca && \
    /usr/bin/sh ./install.sh

ENV PATH=/chia-blockchain/venv/bin:$PATH
WORKDIR /chia-blockchain

COPY docker-start.sh /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/

RUN apt-get update && apt-get install -y apache2 apache2-utils
RUN touch /var/www/html/blockchain_v1_mainnet.sqlite
RUN chown -R www-data:www-data /var/www/html

COPY job.sh /
RUN apt-get update && apt-get install -y cron
COPY crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab &&\
    crontab /etc/cron.d/crontab

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["docker-start.sh"]
