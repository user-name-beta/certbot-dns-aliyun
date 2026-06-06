FROM certbot/certbot:latest

RUN apk add docker-cli
RUN pip install --root-user-action=ignore certbot-dns-aliyun
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
