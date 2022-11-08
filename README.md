[![MIT License](https://img.shields.io/npm/l/stack-overflow-copy-paste.svg?style=flat-square)](http://opensource.org/licenses/MIT)

# Lattesoft DevOps Script
## Install Jenkins

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/install/ubuntu/jenkins.sh)" '' -h
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
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/install/ubuntu/jenkins.sh)"
```

Setup Jenkins and generate nginx file

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/install/ubuntu/jenkins.sh)" '' -d jenkins.example.com
```

Setup Jenkins, generate nginx file and update Cloudflare DNS (CNAME).

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/install/ubuntu/jenkins.sh)" '' \
-d jenkins.example.com \
-cz a4b6339fdb9dvdf4e7d34327c5a01243 \
-ct kmKnSpBCEvvfsRXLiLSkE8gR6TtvtWSc \
-cdt CNAME \
-cdc host.example.com
```

Setup Jenkins, generate nginx file and update Cloudflare DNS (A).

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/install/ubuntu/jenkins.sh)" '' \
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
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/util/nginx-generate-config.sh)" '' -h
```
| Parameter                                      | Description                       |
|------------------------------------------------|-----------------------------------|
| `-h, --help`                                   | show brief help                   |
| `-d, --domain=DOMAIN_NAME`                     | specify a domain name             |
| `-sn, --server-name=SERVER_NAME`               | specify a server name             |
| `-p, --port=PORT`                              | specify a container port          |

### Example

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/util/nginx-generate-config.sh)" '' \
-d domain.example.com \
-sn server.example.com \
-p 8080
```
<br/>

---
## Setup Let's encrypt ssl certificate

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/util/certbot-generate-cert.sh)" '' -h
```

| Parameter                                      | Description                       |
|------------------------------------------------|-----------------------------------|
| `-h, --help`                                   | show brief help                   |
| `-d, --domain=DOMAIN_NAME`                     | specify a domain name             |

### Example

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/util/certbot-generate-cert.sh)" '' -d example.com
```

<br/>

---
## Update cloudflare DNS

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/util/cloudflare-update-dns.sh)" '' -h
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
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/util/cloudflare-update-dns.sh)" '' \
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
## Run MongoDB container

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/docker/run-mongodb.sh)" '' -h
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
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/docker/run-mongodb.sh)" '' \
-n mongo \
-p 27017 \
-u admin \
-pa pass 
```

Run MongoDB and setup host name

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/docker/run-mongodb.sh)" '' \
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

<br/>

---
## Build and run application container

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/docker/build-run-app.sh)" '' -h
```

| Parameter                                     | Description                                       |
|-----------------------------------------------|---------------------------------------------------|
| `-h, --help`                                  | show brief help                                   |
| `-f, --docker-file=Dockerfile`                | specify a docker file name (Default: Dockerifle)  |
| `-i, --image-name=IMAGE_NAME`                 | specify an image name                             |
| `-c, --container-name=CONTAINER_NAME`         | specify a container name                          |
| `-p, --port=PORT`                             | specify a container port                          |
| `-d, --domain=DOMAIN_NAME`                    | specify a domain name                             |
| `-sn, --server-name=SERVER_NAME`              | specify a server name                             |
| `-cz, --cloudflare-zone=ZONE_ID`              | specify a CloudFlare zone ID.                     |
| `-ct, --cloudflare-token=TOKEN`               | specify a CloudFlare token                        |
| `-cdt, --cloudflare-dns-type=DNS_TYPE`        | specify a CloudFlare DNS type                     |
| `-cdc, --cloudflare-dns-content=DNS_CONTENT`  | specify a CloudFlare DNS type                     |
| `-l, --link=LINK_CONTAINER`                   | specify a container to link                       |

### Example

Run only application container

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/docker/build-run-app.sh)" '' \
-f Dockerfile \
-i company/example-image \
-c example-container \
-p 3000
```

Run application and setup host name

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/docker/build-run-app.sh)" '' \
-f Dockerfile \
-i company/example-image \
-c example-container \
-p 3000
-d app.example.com \
-cz a4b6339fdb9dvdf4e7d34327c5a01243 \
-ct kmKnSpBCEvvfsRXLiLSkE8gR6TtvtWSc \
-cdt CNAME \
-cdc host.example.com

```

Run application and setup multiple host name.

Cloudflare zone must be multiple ID depend on server name.

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/docker/build-run-app.sh)" '' \
-f Dockerfile \
-i company/example-image \
-c example-container \
-p 3000
-d app.example.com \
-sn app.example.com,app2.example.com
-cz a4b6339fdb9dvdf4e7d34327c5a01243,a4b6339fdb9dvdf4e7d34327c5a01243 \
-ct kmKnSpBCEvvfsRXLiLSkE8gR6TtvtWSc \
-cdt CNAME \
-cdc host.example.com

```

Link container name

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/docker/build-run-app.sh)" '' \
-f Dockerfile \
-i company/example-image \
-c example-container \
-p 3000
-d app.example.com \
-l container1:c1

```

<br>

---
## Run Longhorn orphaned volumn

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/longhorn/run-orphaned-volumn.sh)" '' ${PVC_NAME}
```

### Example

Run only application container

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/longhorn/run-orphaned-volumn.sh)" '' \
pvc-23a7c4c3-5494-4d4d-826b-985e8f658030-b5bbf238 \
pvc-5e2c43b6-40d3-47cf-b0bd-250027c196e9-11ebf7d
```

<br>

---
## Run Longhorn volumn replacing command

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/longhorn/replace-volumn.sh)" '' "${PVC_TARGET_NAME};${PVC_SOURCE_NAME}"
```

### Example

Run replacing command

```shell
bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/longhorn/replace-volumn.sh)" '' \
"pvc-23a7c4c3-5494-4d4d-826b-985e8f658030-b5bbf238;pvc-5e2c43b6-40d3-47cf-b0bd-250027c196e9-11ebf7d" \
"pvc-5e2c43b6-40d3-47cf-b0bd-250027c196e9-11ebf7d;pvc-5e2c43b6-40d3-47cf-b0bd-250027c196e9-11ebf7d"
```

<br>

## License

MIT

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fsharvit%2Fmongoose-data-seed.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fsharvit%2Fmongoose-data-seed?ref=badge_shield)
[![MIT License](https://img.shields.io/npm/l/stack-overflow-copy-paste.svg?style=flat-square)](http://opensource.org/licenses/MIT)
