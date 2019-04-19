# Create cloudflare credentials file
mkdir -p /root/.secrets/certbot
if [ -z $DNS_CLOUDFLARE_EMAIL ] || [ -z $DNS_CLOUDFLARE_API_KEY ]; then
  echo email or api key is undefined
  exit 1
fi
echo dns_cloudflare_email = \"$DNS_CLOUDFLARE_EMAIL\" >> /root/.secrets/certbot/cloudflare.ini
echo dns_cloudflare_api_key = \"$DNS_CLOUDFLARE_API_KEY\" >> /root/.secrets/certbot/cloudflare.ini
chmod 600 /root/.secrets/certbot/cloudflare.ini

# Init Certbot if domain directory is not exists
if [ ! -d "/etc/letsencrypt/live/$DOMAIN_NAME" ]; then
  certbot certonly \
    --dns-cloudflare \
    --dns-cloudflare-credentials /root/.secrets/certbot/cloudflare.ini \
    --server https://acme-v02.api.letsencrypt.org/directory \
    -n \
    --agree-tos \
    -m ${DNS_CLOUDFLARE_EMAIL} \
    -d ${DOMAIN_NAME} \
    -d *.${DOMAIN_NAME}
fi

# Run Nginx
nginx -g 'daemon off;'
