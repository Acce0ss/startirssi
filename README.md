startirssi
==========

simple script and cronjob to start irssi on reboot

instructions
============

1. Choose a name for your session
2. setup the cronjob by running 

./setup.sh your_session_name

3. you will be interactively asked for autosetup parameters; 
   server address, port, network and channels
   follow the instructions, there are no error checks currently.
   you can reset the config by

rm ~/.irssi/config
rm -r ~/.irssi/scripts
   
   or similarly, note that above command removes any other configuration
   or scripts you may have had.

The setup installs a script "startirssi.sh" with u+x permissions
and adds "@reboot ~/startirssi.sh" to the end of your crontab.
Furthermore, the irssi session is started.

Now, you can attach to the session with
screen -r your_session_name

Notes
=====

Edit the installed ~/startirssi.sh to add launching different screen
sessions with different irssi configurations.
