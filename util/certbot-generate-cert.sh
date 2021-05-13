DOMAIN_NAME="$1"

if ! which certbot > /dev/null 2>&1; then
    echo "Certbot not installed"
    wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/install/ubuntu/certbot.sh | sudo bash
fi

sudo certbot --nginx --redirect --noninteractive --agree-tos --register-unsafely-without-email -d $DOMAIN_NAME
