FROM certbot/certbot:latest

RUN pip install certbot-dns-aliyun

ENTRYPOINT ["certbot", "certonly", "--dns-aliyun"]
