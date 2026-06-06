# 使用 certbot-dns-aliyun 插件的 certbot Docker 镜像

有时，我们需要使用[阿里云](https://www.aliyun.com)来[管理DNS解析条目](https://dns.console.aliyun.com)，
但我们又希望使用[certbot](https://certbot.eff.org)获取[Let's Encrypt](https://letsencrypt.org)证书。
在用于生产的宿主机手动进行上述操作比较繁琐且易出错。
这个仓库提供了一个简单但可靠的解决方案。

这个仓库提供了一个[Docker 镜像](https://hub.docker.com/repository/docker/usernamebeta/certbot-dns-aliyun/general)。
运行这个镜像，即可立刻自动进行证书续订。环境变量：
  - `CERTBOT_EMAIL` 
    邮箱。强烈建议填写，以便在出现突发事件（例如证书私钥泄漏）时能够快速处理。
  - `CERTBOT_DOMAIN`
    **必填**。指定为哪个域名签发证书。可以使用通配符，例如*.example.com。注意*.example.com
    不包括example.com。多个域名用逗号分割。
  - `CERTBOT_DNS_ALIYUN_ACCESS_KEY`
    **必填**。指定阿里云Access Key的ID。
  - `CERTBOT_DNS_ALIYUN_SECRET_KEY`
    **必填。指定阿里云Access Key密钥。需要保密，不应提交到Git仓库活硬编码到脚本。
  - `CERTBOT_DEPLOY_HOOK`
    选填，用于指定证书成功签发后执行的命令。

这个镜像的名称为`usernamebeta/certbot-dns-aliyun`。

示例：
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

这会为example.com和所有子域名续订证书，一旦成功，将重启名为nginx的容器内部的Nginx服务器。

[这里](https://github.com/user-name-beta/certbot-dns-aliyun/blob/main/docker-compose.example.yml)
还有一个Docker Compose的配置文件作为示例，它会自动重启Nginx服务。

# 许可证
本软件使用MIT许可证。
