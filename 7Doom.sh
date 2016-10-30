#!/bin/bash
################################################
# 7 Days To Die - Out of memory prevent crash  #
################################################
# Author:       Maik Laschober <Devidian>
# SteamId:      76561197972223708
# E-Mail:       webmaster@omega-center.com
#
# Description:  This script checks if any Out of Memory exception is thrown in the current output log
#		If so, it shuts down the server within a minute to prevent server crashing itself and
#		have a clean shutdown instead.

INSTANCE=$1;
PORT=$2;
LNG=$3;
SD="/usr/local/bin/7dtd.sh";
DT=`date "+%Y-%m-%d %H-%M"`;
# MTF prevents the anti zombie process to restart the instance
MTF="/root/$INSTANCE.mtf";

# Language / translation
if [ "$LNG" == "en" ]; then
	TEXT[0]='say "[80000]!WARNING![-] Server is out of memory! Possible memory leak."';
	TEXT[1]='say "Shutdown in 60 seconds, restart may take some minutes." ';
	TEXT[2]='say "Shutdown in 10..."';
	TEXT[3]='say "Shutdown in 5..."';
else
	TEXT[0]='say "[80000]!WARNUNG![-] Speicherverbrauch des Servers zu hoch (Memoryleak)!"';
	TEXT[1]='say "Shutdown in 60 Sekunden, Neustart kann ein paar Minuten dauern!" ';
	TEXT[2]='say "Shutdown in 10..."';
	TEXT[3]='say "Shutdown in 5..."';
fi;


if [ $1 ]; then
	OOM=$(cat "/home/sdtd/instances/$INSTANCE/logs/current_output_log.txt" | grep "EXC Out" | wc -l);

	if [ "$OOM" -gt "0" ]; then
		touch $MTF;
		echo "[$DT] Server instance:  $INSTANCE out of Memory!";
		{	echo ${TEXT[0]};
			echo ${TEXT[1]};
			sleep 50;
			echo ${TEXT[2]};
			sleep 5;
			echo ${TEXT[3]};
			sleep 5;
			echo 'saveworld';
			sleep 1;
			echo 'shutdown';
			sleep 1; } | telnet localhost $PORT
		sleep 60;
		$SD start $INSTANCE;
		sleep 600;
		rm $MTF;
	#else
	#        echo "Alles gut!";
	fi;
fi;
