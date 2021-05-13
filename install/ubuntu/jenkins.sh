DOMAIN="$1"
CLOUDFLARE_ZONE="$2"
CLOUDFLARE_TOKEN="$3"
CLOUDFLARE_DNS_TYPE="$4"
CLOUDFLARE_DNS_CONTENT="$5"


## Install Java
if ! which java > /dev/null 2>&1; then
	echo "Java is not istalled"
	sudo apt update -y
	sudo apt install openjdk-11-jdk -y
	java -version
fi


## Install Jenkins
echo "Jenkins is not istalled"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list' -y
sudo apt-get update -y
sudo apt-get install jenkins -y

## Nginx Setup
if [ -n "$1" ]; then
	echo "Domain name is not empty."

	if ! which nginx > /dev/null 2>&1; then
    	   echo "Nginx not installed"
	   sudo bash ./nginx.sh
	fi
	sudo bash ../../util/nginx-generate-config.sh $DOMAIN $DOMAIN 8080
	if ! which certbot > /dev/null 2>&1; then
           echo "Certbot not installed"
           sudo bash ./certbot.sh
        fi
	sudo bash ../../util/certbot-generate-cert.sh $DOMAIN
	if [ -n "$2" ] && [ -n "$3" ] && [ -n "$4" ] && [ -n "$5" ]; then
		echo "Cloudflare Config is not empty."
		sudo bash ../../util/cloudflare-update-dns.sh $CLOUDFLARE_ZONE $CLOUDFLARE_TOKEN $DOMAIN $CLOUDFLARE_DNS_TYPE $CLOUDFLARE_DNS_CONTENT 120 false
	fi
fi
