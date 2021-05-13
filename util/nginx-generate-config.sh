## Generate nginx config file
DOMAIN_NAME="$1"
SERVER_NAME="$2"
PORT="$3"

if ! which nginx > /dev/null 2>&1; then
    echo "Nginx not installed"
    wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/install/ubuntu/nginx.sh | sudo bash
fi

echo ">> Generating nginx config file" &&
sudo cat << EOF > /etc/nginx/sites-available/$DOMAIN_NAME
server {
    listen   80;
    server_name  $SERVER_NAME;
    location / {
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
	    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
	    proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header X-Forwarded-Port \$server_port;
        proxy_set_header X-Forwarded-Server \$host;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_pass http://0.0.0.0:$PORT;
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
