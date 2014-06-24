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


SCRIPT_PATH=~/.irssi/scripts

echo "Making script and autorun directories under ~/.irssi ..."
mkdir -p $SCRIPT_PATH/autorun

echo "Copying setup script..."
cp startirssi_autosetup_template.pl $SCRIPT_PATH/autosetup.pl

echo "Give the server you want to add in format \"address port network\" (ex. input \"eu.ircnet.org 6667 IRCnet\""
read address port network

echo "Give space separated list of channels you want to join. (ex. input \"#help #korpienot-must-die\""
read channels

echo "Preparing autosetup..."
sed -i.bak s/'<CHANNELS>'/"$channels"/g $SCRIPT_PATH/autosetup.pl
sed -i s/'<ADDRESS>'/$address/g $SCRIPT_PATH/autosetup.pl
sed -i s/'<NETWORK>'/$network/g $SCRIPT_PATH/autosetup.pl
sed -i s/'<PORT>'/$port/g $SCRIPT_PATH/autosetup.pl

echo "symlink for autorunning the setup script..."
ln -s $SCRIPT_PATH/autosetup.pl $SCRIPT_PATH/autorun/autosetup.pl

~/startirssi.sh

echo "Please wait while script initializes..."
sleep 3

screen -S $1 -X quit

echo "Removing autosetup script..."
rm $SCRIPT_PATH/autorun/autosetup.pl

echo "Starting the screen session now..."
~/startirssi.sh

echo "Done! Attach session by 'screen -r $1' and have fun!"
