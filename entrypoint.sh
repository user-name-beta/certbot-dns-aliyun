#!/bin/sh

set -e

cat <<EOF > /etc/letsencrypt/aliyun.ini
dns_aliyun_access_key = $CERTBOT_DNS_ALIYUN_ACCESS_KEY
dns_aliyun_access_key_secret = $CERTBOT_DNS_ALIYUN_SECRET_KEY
EOF

chmod 600 /etc/letsencrypt/aliyun.ini

CMD="certbot certonly --authenticator dns-aliyun --agree-tos --non-interactive --dns-aliyun-credentials /etc/letsencrypt/aliyun.ini"

if test "x$CERTBOT_EMAIL" = "x"; then
    CMD="$CMD --register-unsafely-without-email"
else
    CMD="$CMD --email $CERTBOT_EMAIL"
fi

if test "x$CERTBOT_DOMAIN" = "x"; then
    echo "Error: CERTBOT_DOMAIN environment variable is not set."
    exit 1
else
    CMD="$CMD -d $CERTBOT_DOMAIN --cert-name ${CERTBOT_DOMAIN%%,*}"
fi

if test "x$CERTBOT_DEPLOY_HOOK" != "x"; then
    CMD="$CMD --deploy-hook $CERTBOT_DEPLOY_HOOK"
fi

exec $CMD
