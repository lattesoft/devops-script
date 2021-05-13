[![MIT License](https://img.shields.io/npm/l/stack-overflow-copy-paste.svg?style=flat-square)](http://opensource.org/licenses/MIT)

# Lattesoft Server Script
## Install Jenkins

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/install/ubuntu/jenkins.sh | sudo bash -s $DOMAIN_NAME $CLOUDFLARE_ZONE $CLOUDFLARE_TOKEN $CLOUDFLARE_DNS_TYPE $CLOUDFLARE_DNS_CONTENT
```

`$DOMAIN_NAME` Jenkins's domain name

`$CLOUDFLARE_ZONE` Cloudflare zone ID (Optional)

`$CLOUDFLARE_TOKEN` Cloudflare token (Optional)

`$CLOUDFLARE_DNS_TYPE` Cloudflare DNS type (Optional)

`$CLOUDFLARE_DNS_CONTENT` Cloudflare DNS content (Optional)

### Example

Setup Jenkins only.

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/install/ubuntu/jenkins.sh | sudo bash
```

Setup Jenkins and generate nginx file

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/install/ubuntu/jenkins.sh | sudo bash -s jenkins.example.com
```

Setup Jenkins, generate nginx file and update Cloudflare DNS (CNAME).

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/install/ubuntu/jenkins.sh | sudo bash -s jenkins.example.com a4b6339fdb9dvdf4e7d34327c5a01243 kmKnSpBCEvvfsRXLiLSkE8gR6TtvtWSc CNAME host.example.com
```

Setup Jenkins, generate nginx file and update Cloudflare DNS (A).

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/install/ubuntu/jenkins.sh | sudo bash -s jenkins.example.com a4b6339fdb9dvdf4e7d34327c5a01243 kmKnSpBCEvvfsRXLiLSkE8gR6TtvtWSc A 1.2.3.4
```
<br/>

---
## Generate nginx config file

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/nginx-generate-config.sh | sudo bash -s $DOMAIN_NAME $SERVER_NAME $PORT
```

`$DOMAIN_NAME` Nginx domain name.

`$SERVER_NAME` Nginx server name.

`$PORT` Docker container port.

### Example

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/nginx-generate-config.sh | sudo bash -s domain.example.com server.example.com 8080
```
<br/>

---
## Setup Let's encrypt ssl certificate

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/certbot-generate-cert.sh | sudo bash -s $DOMAIN_NAME
```

`$DOMAIN_NAME` Web domain name.

### Example

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/certbot-generate-cert.sh | sudo bash -s example.com
```

<br/>

---
## Update cloudflare DNS

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/cloudflare-update-dns.sh | sudo bash -s $CLOUDFLARE_ZONE $CLOUDFLARE_TOKEN $DOMAIN_NAME $CLOUDFLARE_DNS_TYPE $CLOUDFLARE_DNS_CONTENT $CLOUDFLARE_DNS_TTL $CLOUDFLARE_DNS_PROXIED
```

`$CLOUDFLARE_ZONE` Cloudflare zone ID.

`$CLOUDFLARE_TOKEN` Cloudflare token.

`$DOMAIN_NAME` Web domain name.

`$CLOUDFLARE_DNS_TYPE` Cloudflare DNS type.

`$CLOUDFLARE_DNS_CONTENT` Cloudflare DNS content.

`$CLOUDFLARE_DNS_TTL` TTL Expiration.

`$CLOUDFLARE_DNS_PROXIED` Cloudflare proxied (true or false).

### Example

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/cloudflare-update-dns.sh | sudo bash -s a4b6339fdb9dvdf4e7d34327c5a01243 kmKnSpBCEvvfsRXLiLSkE8gR6TtvtWSc jenkins.example.com A 1.2.3.4 120 false
```

<br/>

---
## Run DB container

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/docker/run-mongodb.sh | sudo bash -s $DB_NAME $PORT $USERNAME $PASSWORD
```

`$DB_NAME` Container name.

`$PORT` Container port.

`$USERNAME` Admin username.

`$PASSWORD` Admin password.

### Example

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/docker/run-mongodb.sh | sudo bash -s mongo 27017 admin pass
```

<br>

## License

MIT

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fsharvit%2Fmongoose-data-seed.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fsharvit%2Fmongoose-data-seed?ref=badge_shield)
[![MIT License](https://img.shields.io/npm/l/stack-overflow-copy-paste.svg?style=flat-square)](http://opensource.org/licenses/MIT)
