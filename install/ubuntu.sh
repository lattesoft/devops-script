
## Install Java
sudo apt update -y
sudo apt install openjdk-11-jdk -y
java -version


## Install Jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list' -y
sudo apt-get update -y
sudo apt-get install jenkins -y
