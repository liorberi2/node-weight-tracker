# This script will automate app installation on Linux VM
# Usage:
# Clone that repo using > git clone https://github.com/ronkaiser/node-weight-tracker.git
# cd to > /home/linux/node-weight-tracker/AutoWeightTracker
# run > chmod u+x WTAPPL.sh
# run the script > ./WTAPPL.sh
# Drink some coffee

# PAY ATTENTION!!!
# Don't forget to update IP in Okta website in login section
# Username and password must be matched to Terraform

#!/bin/bash

# nodejs installation
curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs
node -v

# npm initialization
cd ~/node-weight-tracker/
sudo npm init -y

# dependencies installation
sudo npm install @hapi/hapi@19 @hapi/bell@12 @hapi/boom@9 @hapi/cookie@11 @hapi/inert@6 @hapi/joi@17 @hapi/vision@6 dotenv@8 ejs@3 postgres@1 -y
sudo npm install --save-dev nodemon@2 -y

# get variables
ip=$(curl https://ipinfo.io/ip)
read -p 'Okta domain: ' domain
read -p 'Okta client ID: ' clientid
read -p 'Okta client secret: ' secret
#read -p 'postgres username: ' username
read -p 'postgres password: ' password
read -p 'DB Server name in Azure: ' servername

# env edit
echo "# Host configuration
PORT=8080
HOST=0.0.0.0
NODE_ENV=development
HOST_URL=http://$ip:8080
COOKIE_ENCRYPT_PWD=superAwesomCOOKIE_ENCRYPT_PWD=superAwesomePasswordStringThatIsAtLeast32CharactersLong! ePasswordStringThatIsAtLeast32CharactersLong!
# Okta configuration
OKTA_ORG_URL=https://$domain
OKTA_CLIENT_ID=$clientid
OKTA_CLIENT_SECRET=$secret
# Postgres configuration
PGHOST=$servername
PGUSERNAME=postgres@$servername
PGDATABASE=postgres
PGPASSWORD=$password
PGPORT=5432" > .env

# DB initialization
sudo npm run initdb

# pm2 to make process run after restart
sudo npm install pm2@latest -g
sudo pm2 start npm -- run dev
sudo pm2 save
sudo pm2 startup
