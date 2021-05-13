## Variables
package="Install jenkins"
while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "$package - attempt to capture frames"
      echo " "
      echo "$package [options] application [arguments]"
      echo " "
      echo "options:"
      echo "-h, --help                                  show brief help"
      echo "-d, --domain=DOMAIN_NAME                    pecify a domain name"
      echo "-cz, --cloudflare-zone=ZONE_ID              specify a CloudFlare zone ID"
      echo "-ct, --cloudflare-token=TOKEN               specify a CloudFlare token"
      echo "-cdt, --cloudflare-dns-type=DNS_TYPE        specify a CloudFlare DNS type"
      echo "-cdc, --cloudflare-dns-content=DNS_CONTENT    specify a CloudFlare DNS type"
      exit 0
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
    *)
      break
      ;;
  esac
done

if ! which certbot > /dev/null 2>&1; then
    echo "Certbot not installed"
    wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/install/ubuntu/certbot.sh | sudo bash
fi

sudo certbot --nginx --redirect --noninteractive --agree-tos --register-unsafely-without-email -d $DOMAIN
