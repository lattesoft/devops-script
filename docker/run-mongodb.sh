# DB_NAME="$1"
# PORT="$2"
# USERNAME="$3"
# PASSWORD="$4"

# DOMAIN="$5"
# CLOUDFLARE_ZONE="$6"
# CLOUDFLARE_TOKEN="$7"
# CLOUDFLARE_DNS_TYPE="$8"
# CLOUDFLARE_DNS_CONTENT="$9"
package="MongoDB Container"

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "$package - attempt to capture frames"
      echo " "
      echo "$package [options] application [arguments]"
      echo " "
      echo "options:"
      echo "-h, --help                                  show brief help"
      echo "-n, --name=NAME                             specify a database name"
      echo "-p, --port=PORT                             specify a database port number"
      echo "-u, --username=USERNAME                     specify an username"
      echo "-pa, --password=PASSWORD                     specify a password"
      echo "-d, --domain=DOMAIN_NAME                    pecify a domain name"
      echo "-cz, --cloudflare-zone=ZONE_ID              specify a CloudFlare zone ID"
      echo "-ct, --cloudflare-token=TOKEN               specify a CloudFlare token"
      echo "-cdt, --cloudflare-dns-type=DNS_TYPE        specify a CloudFlare DNS type"
      echo "-cdc, --cloudflare-dns-content=DNS_CONTENT    specify a CloudFlare DNS type"
      exit 0
      ;;
    -n)
      shift
      if test $# -gt 0; then
        export DB_NAME=$1
      else
        echo "no database name specified"
        exit 1
      fi
      shift
      ;;
    --name*)
      export DB_NAME=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
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
    -u)
      shift
      if test $# -gt 0; then
        export USERNAME=$1
      else
        echo "no username specified"
        exit 1
      fi
      shift
      ;;
    --username*)
      export USERNAME=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -pa)
      shift
      if test $# -gt 0; then
        export PASSWORD=$1
      else
        echo "no password specified"
        exit 1
      fi
      shift
      ;;
    --password*)
      export PASSWORD=`echo $1 | sed -e 's/^[^=]*=//g'`
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
    -cz)
      shift
      if test $# -gt 0; then
        export CLOUDFLARE_ZONE=$1
      else
        echo "no cloudflare zone specified"
        exit 1
      fi
      shift
      ;;
    --cloudflare-zone*)
      export CLOUDFLARE_ZONE=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -ct)
      shift
      if test $# -gt 0; then
        export CLOUDFLARE_TOKEN=$1
      else
        echo "no cloudflare token specified"
        exit 1
      fi
      shift
      ;;
    --cloudflare-token*)
      export CLOUDFLARE_TOKEN=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -cdt)
      shift
      if test $# -gt 0; then
        export CLOUDFLARE_DNS_TYPE=$1
      else
        echo "no cloudflare DNS type specified"
        exit 1
      fi
      shift
      ;;
    --cloudflare-dns-type*)
      export CLOUDFLARE_DNS_TYPE=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -cdc)
      shift
      if test $# -gt 0; then
        export CLOUDFLARE_DNS_CONTENT=$1
      else
        echo "no cloudflare DNS type specified"
        exit 1
      fi
      shift
      ;;
    --cloudflare-dns-content*)
      export CLOUDFLARE_DNS_CONTENT=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    *)
      break
      ;;
  esac
done

echo "DB_NAME=$DB_NAME"
echo "PORT=$PORT"
echo "USERNAME=$USERNAME"
echo "PASSWORD=$PASSWORD"

echo "DOMAIN=$DOMAIN"
echo "CLOUDFLARE_ZONE=$CLOUDFLARE_ZONE"
echo "CLOUDFLARE_TOKEN=$CLOUDFLARE_TOKEN"
echo "CLOUDFLARE_DNS_TYPE=$CLOUDFLARE_DNS_TYPE"
echo "CLOUDFLARE_DNS_CONTENT=$CLOUDFLARE_DNS_CONTENT"


docker 2>/dev/null 1>&2 stop $DB_NAME || true
docker 2>/dev/null 1>&2 rm $DB_NAME || true 

echo ">> Running database container"
docker run -p $PORT:27017 -d \
	-v /var/db/mongo/$DB_NAME:/data/db \
    -e MONGO_INITDB_ROOT_USERNAME=$USERNAME \
    -e MONGO_INITDB_ROOT_PASSWORD=$PASSWORD \
    --name $DB_NAME --restart always mongo


## Domain Setup
if [ -n "$1" ]; then
	echo "Setting up domain name"
	bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/nginx-generate-config.sh)" "" --domain=$DOMAIN --server-name=$DOMAIN --port=$PORT
	if [ -n "$DOMAIN" ] && [ -n "$CLOUDFLARE_ZONE" ] && [ -n "$CLOUDFLARE_TOKEN" ] && [ -n "$CLOUDFLARE_DNS_TYPE" ] && [ -n "$CLOUDFLARE_DNS_CONTENT" ]; then
		echo "Cloudflare config is not empty."
		bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/cloudflare-update-dns.sh)" "" -cz $CLOUDFLARE_ZONE -ct $CLOUDFLARE_TOKEN -d $DOMAIN -cdt $CLOUDFLARE_DNS_TYPE -cdc $CLOUDFLARE_DNS_CONTENT -cdtl 120 -cdp false
	fi
fi