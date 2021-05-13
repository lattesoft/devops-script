## Update coudflare DNS
CLOUDFLARE_ZONE="$1"
CLOUDFLARE_TOKEN="$2"
DOMAIN_NAME="$3"
CLOUDFLARE_DNS_TYPE="$4"
CLOUDFLARE_DNS_CONTENT="$5"
CLOUDFLARE_DNS_TTL="$6"
CLOUDFLARE_DNS_PROXIED="$7"

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
