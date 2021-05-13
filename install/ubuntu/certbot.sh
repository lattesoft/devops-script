## Install jenkins
sudo apt-get install software-properties-common python-software-properties -y
sudo add-apt-repository ppa:certbot/certbot -y
sudo apt-get update -y
sudo apt-get install python-certbot-apache -y


## Automatic renewal
sudo bash -c 'echo "0 0 1 * * /usr/bin/letsencrypt renew >> /var/log/letsencrypt-renew.log" >> /etc/cron.d/certbot'
sudo service cron restart
