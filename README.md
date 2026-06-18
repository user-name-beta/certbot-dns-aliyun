# certbot Docker image with certbot-dns-aliyun plugin

> [!NOTE]
> This GitHub repository is no longer maintained, but it still
> can be used in Docker Hub. The image will still be maintained.

[Chinese Version](https://github.com/user-name-beta/certbot-dns-aliyun/blob/main/README.cn.md)

Sometimes, we need to use [Alibaba Cloud](https://www.aliyun.com) to [manage DNS records](https://dns.console.aliyun.com),
but we also want to obtain [Let's Encrypt](https://letsencrypt.org) certificates using [certbot](https://certbot.eff.org).
Manually performing the above operations on a production host is cumbersome and error-prone.
This repository provides a simple yet reliable solution.

This repository provides a [Docker image](https://hub.docker.com/repository/docker/usernamebeta/certbot-dns-aliyun/general).
Running this image will automatically renew certificates immediately. Environment variables:
  - `CERTBOT_EMAIL` 
    Email address. Strongly recommended so that you can respond quickly to emergencies (e.g., certificate private key leakage).
  - `CERTBOT_DOMAIN`
    **Required**. Specify which domain the certificate should be issued for. Wildcards can be used, e.g., *.example.com. Note that *.example.com
    does not include example.com. Multiple domains are separated by commas.
  - `CERTBOT_DNS_ALIYUN_ACCESS_KEY`
    **Required**. Specify the Alibaba Cloud Access Key ID.
  - `CERTBOT_DNS_ALIYUN_SECRET_KEY`
    **Required**. Specify the Alibaba Cloud Access Key secret. Keep it confidential, do not commit to Git repositories or hardcode in scripts.
  - `CERTBOT_DEPLOY_HOOK`
    Optional. Specify a command to execute after the certificate is successfully issued.

The name of this image is `usernamebeta/certbot-dns-aliyun`.

Example:
```bash
# docker pull usernamebeta/certbot-dns-aliyun
# docker run -e CERTBOT_EMAIL=myemail@example.com \
-e CERTBOT_DOMAIN=example.com,*.example.com \
-e CERTBOT_DNS_ALIYUN_ACCESS_KEY=LTAI2Q3tfFEL2ZpYXKLObgDTbu/wFB79 \
-e CERTBOT_DNS_ALIYUN_SECRET_KEY=2zm25ctuOah+B//ZlC8lxYiuC+r1iVuVIEtCoPWTdVVlczBG5G6NeQ== \
-v /var/run/docker.sock:/var/run/docker.sock \
-e CERTBOT_DEPLOY_HOOK="docker exec nginx nginx -s reload" \
usernamebeta/certbot-dns-aliyun
```

This will renew the certificate for example.com and all subdomains. Once successful, it will restart the Nginx server inside the container named nginx.

[Here](https://github.com/user-name-beta/certbot-dns-aliyun/blob/main/docker-compose.example.yml)
is also a Docker Compose configuration file example that automatically restarts the Nginx service.

# License

This software is licensed under the MIT license.
