 <#
This script will automate WeightTracker app deployment on Windows.
Reference: https://github.com/ronkaiser/node-weight-tracker
#>

# Set execution policy to Bypass and install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
 
# Install Node JS using choco
choco install -y nodejs

# Install git
choco install -y git.install 

# Clone repo
$env:Path += ";C:\Program Files\Git\bin\"
$env:Path += ";C:\Program Files\Git\cmd\"
cd c:\
git clone https://github.com/ronkaiser/node-weight-tracker.git
cd .\node-weight-tracker\

# Initialize project and install dependencies using npm 
npm init -y
npm install @hapi/hapi@19 @hapi/bell@12 @hapi/boom@9 @hapi/cookie@11 @hapi/inert@6 @hapi/joi@17 @hapi/vision@6 dotenv@8 ejs@3 postgres@1
npm install --save-dev nodemon@2
npm run initdb
