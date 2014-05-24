#!/bin/sh
echo "Installing irssi-on-reboot cronjob..."

echo "Copying 'startirssi.sh' to ~"
cp startirssi.sh ~/startirssi.sh

echo "Setting file permissions"
chmod u+x ~/startirssi.sh

echo "Setting screen session name to '$1'"
sed -i.bak s/\$1/$1/g ~/startirssi.sh

if crontab -l | grep -q "@reboot ~/startirssi.sh";
then
	echo "Cronjob already exists, let's not duplicate..."
else
	echo "Adding the cronjob..."
	(crontab -l ; echo "@reboot ~/startirssi.sh") | crontab
fi

echo "Starting the screen session now..."
~/startirssi.sh

echo "Done! Have fun!"
