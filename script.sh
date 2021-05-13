#!/bin/bash
## Generating new port
IS_RANDOM_PORT_EMPTY=false
GET_RANDOM_PORT() {
  RANDOM_PORT=$(shuf -i 2000-65000 -n 1)
  RUNNING_PORT=$(sudo /usr/bin/lsof -t -i:$RANDOM_PORT)
  echo Random port: $RANDOM_PORT.
  if [ -z "$RUNNING_PORT" ]
  then
    echo Port $RANDOM_PORT is empty.
    IS_RANDOM_PORT_EMPTY=true
  fi
}

GET_RANDOM_PORT
while [ "$IS_RANDOM_PORT_EMPTY" = false ]; do
   echo $RANDOM_PORT is running. Generating new port.
   GET_RANDOM_PORT
done


## Build Docker
echo ">> Building image" &&
docker build -f $DOCKER_FILE -t $IMAGE_NAME . && 
echo ">> Building image" &&
docker 2>/dev/null 1>&2 stop $CONTAINER_NAME || true &&
docker 2>/dev/null 1>&2 rm $CONTAINER_NAME || true && 
echo ">> Running container" &&
docker run -p $RANDOM_PORT:$PORT -d --name $CONTAINER_NAME --restart always $IMAGE_NAME && 
echo ">> Cleaning unused images" &&
docker 2>/dev/null 1>&2 rmi `docker images -f "dangling=true" -q` || true


## Nginx config
echo ">> Generating nginx config file" &&
sudo cat << EOF > /etc/nginx/sites-available/$DOMAIN_NAME
server {
    listen   80;
    server_name  $SERVER_NAME;
    location / {
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
	proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Host \$host:\$server_port;
        proxy_set_header X-Forwarded-Server \$host;

        proxy_pass http://0.0.0.0:$RANDOM_PORT;
    }
}
EOF

echo ">> Link file from nginx available folder to nginx enable folder"
FILE=/etc/nginx/sites-enabled/$DOMAIN_NAME
if [ -f "$FILE" ]; then
    echo ">> $FILE exists."
else
    ln -s /etc/nginx/sites-available/$DOMAIN_NAME /etc/nginx/sites-enabled
    echo ">> Link nginx config file success."
fi

echo ">> Reloading nginx configuration"
sudo /usr/sbin/nginx -t
sudo /usr/sbin/nginx -t 2>/dev/null > /dev/null
if [[ $? == 0 ]]; then
 sudo /usr/sbin/service nginx reload
 echo ">> Nginx is reloaded."
else
 echo ">> Nginx test fail!"
fi


## Update cloudflare DNS
echo ">> Updating dns record to cloudflare"
FIND_DNS=$(curl -X GET "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE/dns_records?name=$DOMAIN_NAME" \
     -H "Content-Type:application/json" \
     -H "Authorization: Bearer $CLOUDFLARE_TOKEN" | jq -r '.result')

COUNT_DNS=$(echo $FIND_DNS | jq length)

if [ $COUNT_DNS -gt 0 ]
then
  echo Updating dns record.
  DNS_RECORD_ID=$(echo $FIND_DNS | jq -r '.[0].id')
  echo $DNS_RECORD_ID
  curl -X PUT https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE/dns_records/$DNS_RECORD_ID \
     -H "Content-Type:application/json" \
     -H "Authorization: Bearer $CLOUDFLARE_TOKEN" \
     --data "{\"name\":\"$DOMAIN_NAME\",\"type\":\"$CLOUDFLARE_DNS_TYPE\",\"content\":\"$CLOUDFLARE_DNS_CONTENT\",\"ttl\":$CLOUDFLARE_DNS_TTL,\"proxied\":$CLOUDFLARE_DNS_PROXIED}"
else
  echo Creating dns record.
  curl -X POST "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE/dns_records" \
     -H "Content-Type:application/json" \
     -H "Authorization: Bearer $CLOUDFLARE_TOKEN" \
     --data "{\"name\":\"$DOMAIN_NAME\",\"type\":\"$CLOUDFLARE_DNS_TYPE\",\"content\":\"$CLOUDFLARE_DNS_CONTENT\",\"ttl\":$CLOUDFLARE_DNS_TTL,\"proxied\":$CLOUDFLARE_DNS_PROXIED}"
fi
