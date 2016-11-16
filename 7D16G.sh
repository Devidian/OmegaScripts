#!/bin/bash
################################################
# 7 Days To Die - unity >16G Memory issue fix  #
################################################
# Author:       Maik Laschober <Devidian>
# SteamId:      76561197972223708
# E-Mail:       webmaster@omega-center.com
#
# Description:  TBD
# unity limit: 16GB ~ ‪16777216‬Kb


LNG=$3;
LIMIT="16000000";
# Language / translation
if [ "$LNG" == "en" ]; then
	TEXT[0]='say "[80000]!WARNING![-] Server is out of memory! Possible >16GB unity memory leak."';
	TEXT[1]='say "Shutdown in 60 seconds, restart may take some minutes." ';
	TEXT[2]='say "Shutdown in 10..."';
	TEXT[3]='say "Shutdown in 5..."';
else
	TEXT[0]='say "[80000]!WARNUNG![-] Speicherverbrauch des Servers zu hoch (>16GB unity Memoryleak)!"';
	TEXT[1]='say "Shutdown in 60 Sekunden, Neustart kann ein paar Minuten dauern!" ';
	TEXT[2]='say "Shutdown in 10..."';
	TEXT[3]='say "Shutdown in 5..."';
fi;


if [ "$1" ] && [ "$2" ]; then

    INSTANCE=$1;
    PORT=$2;
    SD="/usr/local/bin/7dtd.sh";
    DT=`date "+%Y-%m-%d %H-%M"`;
    # MTF prevents the anti zombie process to restart the instance
    MTF="/root/$INSTANCE.mtf";
	RUNNING=$($SD instances list | grep $instance".*yes"|awk '{print $3}');

    if [ "$RUNNING" ]; then

        PROCESSES=$(ps axjf|grep "^    1.*"$instance);
        if [ "$PROCESSES" ]; then
			PIDLIST=$(echo "$PROCESSES"|awk '{print $2}');
            # should only be 1 process
			for PID in $PIDLIST; do
                VIRT=$(awk 'match($1,"VmPeak"){print $2}' /proc/$PID/status)
				if [ "$VIRT" -gt "16000000" ]; then
                    pmap $PID > "~/${DT}memIssue.log";
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
                fi;
			done

        fi;
    fi;

fi;