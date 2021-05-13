## Variables
package="Update cloudflare DNS"
while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "$package - attempt to capture frames"
      echo " "
      echo "$package [options] application [arguments]"
      echo " "
      echo "options:"
      echo "-h, --help                                      show brief help"
      echo "-d, --domain=DOMAIN_NAME                        pecify a domain name"
      echo "-cz, --cloudflare-zone=ZONE_ID                  specify a CloudFlare zone ID"
      echo "-ct, --cloudflare-token=TOKEN                   specify a CloudFlare token"
      echo "-cdt, --cloudflare-dns-type=DNS_TYPE            specify a CloudFlare DNS type"
      echo "-cdc, --cloudflare-dns-content=DNS_CONTENT      specify a CloudFlare DNS type"
      echo "-cdtl, --cloudflare-dns-ttl=TTL                 specify a CloudFlare DNS TTL (Secound)"
      echo "-cdp, --cloudflare-dns-proxied=PROXIED          specify a CloudFlare DNS proxied (true or false)"
      exit 0
      ;;
    -d)
      shift
      if test $# -gt 0; then
        export DOMAIN_NAME=$1
      else
        echo "no domain name specified"
        exit 1
      fi
      shift
      ;;
    --domain*)
      export DOMAIN_NAME=`echo $1 | sed -e 's/^[^=]*=//g'`
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
     -cdtl)
      shift
      if test $# -gt 0; then
        export CLOUDFLARE_DNS_TTL=$1
      else
        echo "no cloudflare DNS TTL specified"
        exit 1
      fi
      shift
      ;;
    --cloudflare-dns-ttl*)
      export CLOUDFLARE_DNS_TTL=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
     -cdp)
      shift
      if test $# -gt 0; then
        export CLOUDFLARE_DNS_PROXIED=$1
      else
        echo "no cloudflare DNS proxied specified"
        exit 1
      fi
      shift
      ;;
    --cloudflare-dns-proxied*)
      export CLOUDFLARE_DNS_PROXIED=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    *)
      break
      ;;
  esac
done





echo ">> Updating dns record to cloudflare"
FIND_DNS=$(curl -X GET "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE/dns_records?name=$DOMAIN_NAME") \
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
