FROM arm32v7/nginx:latest

RUN sed -i "$ a\deb http://deb.debian.org/debian stretch-backports main" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install python3-certbot-dns-cloudflare -t stretch-backports -y && \
    rm -rf /var/lib/apt/lists/*

COPY ./scripts/entrypoint.sh /bin
COPY ./scripts/cronjob /etc/cron.d/certbot

EXPOSE 80 443

ENTRYPOINT ["sh", "-c", "/bin/entrypoint.sh"]
