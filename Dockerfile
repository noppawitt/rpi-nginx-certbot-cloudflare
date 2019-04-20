FROM nginx:latest

RUN sed -i "$ a\deb http://deb.debian.org/debian stretch-backports main" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install python3-certbot-dns-cloudflare -t stretch-backports -y && \
    rm -rf /var/lib/apt/lists/*

COPY ./scripts/entrypoint.sh /usr/bin
COPY ./scripts/cronjob /etc/cron.d/certbot

EXPOSE 80 443

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
