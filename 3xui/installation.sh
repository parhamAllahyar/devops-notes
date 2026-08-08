sudo apt update

sudo apt install curl -y

curl -Ls https://raw.githubusercontent.com/MHSanaei/3x-ui/master/install.sh -o /tmp/3x-ui-install.sh

sudo env VERSION=3.6.0 bash /tmp/3x-ui-install.sh