#!/bin/sh
echo "Installing irssi-on-reboot cronjob..."

echo "Copying 'startirssi.sh' to ~"
cp startirssi.sh ~/startirssi.sh

echo "Setting file permissions"
chmod u+x ~/startirssi.sh

echo "Setting screen session name to '$1'"
sed -i.bak s/\$1/$1/g ~/startirssi.sh

echo "Adding the cronjob..."
(crontab -l ; echo "@reboot ~/startirssi.sh") | crontab

echo "Done! Have fun!"
