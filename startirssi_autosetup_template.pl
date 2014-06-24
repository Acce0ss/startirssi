use strict;
use vars qw($VERSION %IRSSI);
use Irssi;

$VERSION = '1.00';
%IRSSI = (
    authors     => 'Asser Lähdemäki',
    contact     => 'acce@denden.pw',
    name        => 'First config for startirssi',
    description => 'Adds a server and channels as defined ' ,
    license     => 'Public Domain',
);

#setup server
print "Adding server <ADDRESS>:<PORT> in <NETWORK>...";
Irssi::command("server ADD -auto -network <NETWORK> <ADDRESS> <PORT>");

#setup channels
my @myChannels = qw(<CHANNELS>);

foreach(@myChannels)
{
	Irssi::command("channel ADD -auto " . $_ . " <NETWORK>");
}

Irssi::command("save");

Irssi::command("connect IRCnet");
