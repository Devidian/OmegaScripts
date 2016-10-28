#!/bin/sh
################################################
# 7 Days To Die - Restart Scripts              #
################################################
# Author:       Maik Laschober <Devidian>
# SteamId:      76561197972223708
# E-Mail:       webmaster@omega-center.com
#
# Description:  For restarting (running) 7 Days to die instances
#   For example on crontab for restarting OZCOOPII every 3 hours:
#
#   0 */3 * * * /root/7Drestart.sh OZCOOPII >> /root/cronlog/7Drestart.log
#
#

INSTANCE=$1;
LNG=$2;
SD="/usr/local/bin/7dtd.sh";
DT=`date "+%Y-%m-%d %H-%M"`;
# MTF prevents the anti zombie process to restart the instance
MTF="/root/$INSTANCE.mtf";

# Language / translation
if [ "$2" -eq "en" ]; then
	TEXT[0]='say "[80000]!WARNING![-] Server is going for a sheduled restart in 5 Minutes!"';
	TEXT[1]='say "Sheduled restart in 60 seconds!" ';
	TEXT[2]='say "Shutdown in 10..."';
	TEXT[3]='say "Shutdown in 5..."';
else
	TEXT[0]='say "[80000]!WARNUNG![-] Server wird in 5 Minuten neu gestartet (geplant)!"';
	TEXT[1]='say "Geplanter neustart in 60 Sekunden" ';
	TEXT[2]='say "Neustart in 10..."';
	TEXT[3]='say "Neustart in 5..."';
fi;

if [ $1 ]; then

	touch $MTF;
  echo "[$DT] Server instance:  $INSTANCE is going to be restarted!";
	{	echo ${TEXT[0]};
		sleep 240;
		echo ${TEXT[1]};
		sleep 50;
		echo ${TEXT[2]};
		sleep 5;
		echo ${TEXT[3]};
		sleep 5;
		echo 'saveworld';
		sleep 1;
		echo 'shutdown';
		sleep 1; } | telnet localhost 8081
	sleep 10;
	$SD start $INSTANCE;
	rm $MTF;

fi;