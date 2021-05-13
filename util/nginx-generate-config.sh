## Generate nginx config file
package="Generate nginx config"
while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "$package - attempt to capture frames"
      echo " "
      echo "$package [options] application [arguments]"
      echo " "
      echo "options:"
      echo "-h, --help                                  show brief help"
      echo "-p, --port=PORT                             specify a database port number"
      echo "-d, --domain=DOMAIN_NAME                    pecify a domain name"
      echo "-sn, --server-name=SERVER_NAME              pecify a server name"
      exit 0
      ;;

    -p)
      shift
      if test $# -gt 0; then
        export PORT=$1
      else
        echo "no port specified"
        exit 1
      fi
      shift
      ;;
    --port*)
      export PORT=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -d)
      shift
      if test $# -gt 0; then
        export DOMAIN=$1
      else
        echo "no domain name specified"
        exit 1
      fi
      shift
      ;;
    --domain*)
      export DOMAIN=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -sn)
      shift
      if test $# -gt 0; then
        export SERVER_NAME=$1
      else
        echo "no server name specified"
        exit 1
      fi
      shift
      ;;
    --server-name*)
      export SERVER_NAME=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    *)
      break
      ;;
  esac
done

if ! which nginx > /dev/null 2>&1; then
    echo "Nginx not installed"
    wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/install/ubuntu/nginx.sh | sudo bash
fi

echo ">> Generating nginx config file" &&
sudo cat << EOF > /etc/nginx/sites-available/$DOMAIN
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
FILE=/etc/nginx/sites-enabled/$DOMAIN
if [ -f "$FILE" ]; then
    echo ">> $FILE exists."
else
    ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled
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
