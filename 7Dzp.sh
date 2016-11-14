#!/bin/sh
################################################
# 7 Days To Die	- Zombie Process killer script #
################################################
# Author: 			Maik Laschober <Devidian>
# SteamId:			76561197972223708
# E-Mail: 			webmaster@omega-center.com
#
# Description:	I had the problem that sometimes my Server crashed when opening player inventory
#		on Alloc's Web-Map. The process is still running and consuming resources so i always
#		had to kill the process before starting the instance again.
#
#		This script should solve the problem, running as cron it can check the instance and
#		kill zombie processes if nessaccary and restart the instance.
#
#		If the instance state is not running and no processes are found, the instance will not
#		start! In this case we assume that the instance was shutdown correct.

# If instance arg1 is set
if [ "$1" ]; then
	instance=$1;
	SD="/usr/local/bin/7dtd.sh";
	DT=`date "+%Y-%m-%d %H-%M"`;
	MTF="/root/$1.mtf"; # Maintainance file
	RUNNING=$($SD instances list | grep $instance".*yes"|awk '{print $3}');

	if [ "$RUNNING" ]; then
		echo "[$DT] Instance $instance is running!";
	else
		echo "[$DT] Instance $instance is NOT running! Checking processlist";

		PROCESSES=$(ps axjf|grep "^    1.*"$instance);
		COUNT=$(echo "$PROCESSES"|wc -l);

		if [ "$PROCESSES" ]; then
			echo "[$DT] Huston, we have $COUNT zombie process(es)";
			PIDLIST=$(echo "$PROCESSES"|awk '{print $2}');
			for PID in $PIDLIST; do
				echo "Master: $PID";
				CHILDLIST=$(ps axjf|grep $PID|awk 'NR>2{print $2}')
				for CHILD in $CHILDLIST; do
					echo "\tChild: $CHILD";
					kill $CHILD;
				done
				kill $PID;
			done
			# Restart the instance
			$SD start $instance;
		else
			# No zombies found
			echo "[$DT] No Zombies running ;)";
			# Check if maintainance mode is active
			if [ ! -f $MTF ]; then
				# no maintainance (instance should run)
				echo "[$DT] No maintainance mode! Starting instance...";
				$SD start $instance;
			fi
		fi
	fi
fi
