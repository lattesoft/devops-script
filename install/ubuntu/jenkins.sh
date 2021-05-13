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


## Install Java
if ! which java > /dev/null 2>&1; then
	echo "Java is not istalled"
	sudo apt update -y
	sudo apt install openjdk-11-jdk -y
	java -version
fi


## Install Jenkins
echo "Installing Jenkins"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list' -y
sudo apt-get update -y
sudo apt-get install jenkins -y

## Nginx Setup
if [ -n "$DOMAIN" ]; then
	echo "Domain name is not empty."
	sudo sh -c "bash -c '$(wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/nginx-generate-config.sh)' '' \
		--domain=$DOMAIN \
		--server-name=$DOMAIN \
		--port=8080"

	bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/certbot-generate-cert.sh)" '' --domain=$DOMAIN
	if [ -n "$CLOUDFLARE_ZONE" ] && [ -n "$CLOUDFLARE_TOKEN" ] && [ -n "$CLOUDFLARE_DNS_TYPE" ] && [ -n "$CLOUDFLARE_DNS_CONTENT" ] ; then
		echo "Cloudflare config is not empty."
		sudo sh -c "bash -c '$(wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/util/cloudflare-update-dns.sh)' '' \
			--cloudflare-zone=$CLOUDFLARE_ZONE \
			--cloudflare-token=$CLOUDFLARE_TOKEN \
			--domain=$DOMAIN \
			--cloudflare-dns-type=$CLOUDFLARE_DNS_TYPE \
			--cloudflare-dns-content=$CLOUDFLARE_DNS_CONTENT \
			--cloudflare-dns-ttl=120 \
			--cloudflare-dns-proxied=false"
	fi
fi

## Setting up jenkins use sudo without password
echo "Setting up jenkins use sudo without password."
sudo sh -c 'echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'
sudo service jenkins restart
if ! which docker > /dev/null 2>&1; then
    echo "Docker not installed"
    wget -q -O - https://raw.githubusercontent.com/lattesoft/server-script/main/install/ubuntu/docker.sh | sudo bash
fi
sudo gpasswd -a jenkins docker
