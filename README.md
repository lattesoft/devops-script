[![MIT License](https://img.shields.io/npm/l/stack-overflow-copy-paste.svg?style=flat-square)](http://opensource.org/licenses/MIT)

# Lattesoft Server Script
## Install Jenkins

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/install/ubuntu/jenkins.sh | sudo bash -h
```

| Parameter                                      | Description                      |
|------------------------------------------------|----------------------------------|
| `-h, --help`                                   | show brief help                  |
| `-d, --domain=DOMAIN_NAME`                     | specify a domain name            |
| `-cz, --cloudflare-zone=ZONE_ID`               | specify a CloudFlare zone ID     |
| `-ct, --cloudflare-token=TOKEN`                | specify a CloudFlare token       |
| `-cdt, --cloudflare-dns-type=DNS_TYPE`         | specify a CloudFlare DNS type    |  
| `-cdc, --cloudflare-dns-content=DNS_CONTENT`   | specify a CloudFlare DNS type    |


### Example

Setup Jenkins only.

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/install/ubuntu/jenkins.sh | sudo bash
```

Setup Jenkins and generate nginx file

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/install/ubuntu/jenkins.sh | sudo bash -s -d jenkins.example.com
```

Setup Jenkins, generate nginx file and update Cloudflare DNS (CNAME).

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/install/ubuntu/jenkins.sh | sudo bash -s \
-d jenkins.example.com \
-cz a4b6339fdb9dvdf4e7d34327c5a01243 \
-ct kmKnSpBCEvvfsRXLiLSkE8gR6TtvtWSc \
-cdt CNAME \
-cdc host.example.com
```

Setup Jenkins, generate nginx file and update Cloudflare DNS (A).

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/install/ubuntu/jenkins.sh | sudo bash -s \
-d jenkins.example.com \
-cz a4b6339fdb9dvdf4e7d34327c5a01243 \
-ct kmKnSpBCEvvfsRXLiLSkE8gR6TtvtWSc \
-cdt A \
-cdc 1.2.3.4
```
<br/>

---
## Generate nginx config file

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/nginx-generate-config.sh | sudo bash -s -h
```
| Parameter                                      | Description                       |
|------------------------------------------------|-----------------------------------|
| `-h, --help`                                   | show brief help                   |
| `-d, --domain=DOMAIN_NAME`                     | specify a domain name             |
| `-sn, --server-name=SERVER_NAME`               | specify a server name             |
| `-p, --port=PORT`                              | specify a container port          |

### Example

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/nginx-generate-config.sh | sudo bash -s \
-d domain.example.com \
-sn server.example.com \
-p 8080
```
<br/>

---
## Setup Let's encrypt ssl certificate

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/certbot-generate-cert.sh | sudo bash -s -h
```

| Parameter                                      | Description                       |
|------------------------------------------------|-----------------------------------|
| `-h, --help`                                   | show brief help                   |
| `-d, --domain=DOMAIN_NAME`                     | specify a domain name             |

### Example

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/certbot-generate-cert.sh | sudo bash -s -d example.com
```

<br/>

---
## Update cloudflare DNS

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/cloudflare-update-dns.sh | sudo bash -s -h
```

| Parameter                                      | Description                                      |
|------------------------------------------------|--------------------------------------------------|
| `-h, --help`                                   | show brief help                                  |
| `-d, --domain=DOMAIN_NAME`                     | specify a domain name                            |
| `-cz, --cloudflare-zone=ZONE_ID`               | specify a CloudFlare zone ID                     |
| `-ct, --cloudflare-token=TOKEN`                | specify a CloudFlare token                       |
| `-cdt, --cloudflare-dns-type=DNS_TYPE`         | specify a CloudFlare DNS type                    |  
| `-cdc, --cloudflare-dns-content=DNS_CONTENT`   | specify a CloudFlare DNS type                    |
| `-cdtl, --cloudflare-dns-ttl=TTL`              | specify a CloudFlare DNS TTL (Secound)           |
| `-cdp, --cloudflare-dns-proxied=PROXIED`       | specify a CloudFlare DNS proxied (true or false) |

### Example

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/cloudflare-update-dns.sh | sudo bash -s \
-cz a4b6339fdb9dvdf4e7d34327c5a01243 \
-ct kmKnSpBCEvvfsRXLiLSkE8gR6TtvtWSc \
-d jenkins.example.com \
-cdt A \
-cdc 1.2.3.4 \
-cdtl 120 \
-cdp false
```

<br/>

---
## Run DB container

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/docker/run-mongodb.sh | sudo bash -s -h
```

| Parameter                                     | Description                                       |
|-----------------------------------------------|---------------------------------------------------|
| `-h, --help`                                  | show brief help                                   |
| `-n, --name=NAME`                             | specify a database name                           |
| `-p, --port=PORT`                             | specify a database port number                    |
| `-u, --username=USERNAME`                     | specify an username                               |
| `-pa, --password=PASSWORD`                    | specify a password                                |
| `-d, --domain=DOMAIN_NAME`                    | pecify a domain name                              |
| `-cz, --cloudflare-zone=ZONE_ID `             | specify a CloudFlare zone ID                      |
| `-ct, --cloudflare-token=TOKEN`               | specify a CloudFlare token                        |
| `-cdt, --cloudflare-dns-type=DNS_TYPE`        | specify a CloudFlare DNS type                     |
| `-cdc, --cloudflare-dns-content=DNS_CONTENT`  | specify a CloudFlare DNS type                     |



### Example

Run only MongoDB

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/docker/run-mongodb.sh | sudo bash -s \
-n mongo \
-p 27017 \
-u admin \
-pa pass 
```

Run MongoDB and setup host name

```shell
wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/docker/run-mongodb.sh | sudo bash -s \
-n mongo \
-p 27017 \
-u admin \
-pa pass \
-d jenkins.example.com \
-cz a4b6339fdb9dvdf4e7d34327c5a01243 \
-ct kmKnSpBCEvvfsRXLiLSkE8gR6TtvtWSc \
-cdt CNAME \
-cdc host.example.com

```

<br>

## License

MIT

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fsharvit%2Fmongoose-data-seed.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fsharvit%2Fmongoose-data-seed?ref=badge_shield)
[![MIT License](https://img.shields.io/npm/l/stack-overflow-copy-paste.svg?style=flat-square)](http://opensource.org/licenses/MIT)
