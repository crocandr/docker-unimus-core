#!/bin/bash

JAVA_EXTRA_PARAMS=""

CONFIG_FILE="/etc/unimus-core/unimus-core.properties"

# default value of unimus server port
[ -z $UNIMUS_SERVER_ADDRESS ] && { UNIMUS_SERVER_ADDRESS=172.17.0.1; }
[ -z $UNIMUS_SERVER_PORT ] && { UNIMUS_SERVER_PORT=8085; }
[ -z $UNIMUS_SERVER_ACCESS_KEY ] && { UNIMUS_SERVER_ACCESS_KEY="NOT_A_VALID_ACCESS_KEY"; }

[ ! -z "$XMS" ] &&  { JAVA_EXTRA_PARAMS="$JAVA_EXTRA_PARAMS -Xms$XMS"; }
[ ! -z "$XMX" ] && { JAVA_EXTRA_PARAMS="$JAVA_EXTRA_PARAMS -Xmx$XMX"; }
[ ! -z "$JAVA_OPTS" ] && { JAVA_EXTRA_PARAMS="$JAVA_OPTS"; }

[ -z "$TZ" ] && { TZ="UTC"; }
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


[ ! -f $CONFIG_FILE ] && { touch $CONFIG_FILE; }
[ ! -z $UNIMUS_SERVER_ADDRESS ] && { sed -i s@unimus.address=.*@unimus.address=$UNIMUS_SERVER_ADDRESS@g $CONFIG_FILE; }
[ $( grep -i "unimus.port=" $CONFIG_FILE | wc -l ) -eq 0 ] && { echo "unimus.port=" >> $CONFIG_FILE; } 
[ ! -z $UNIMUS_SERVER_PORT ] && { sed -i s@unimus.port=.*@unimus.port=$UNIMUS_SERVER_PORT@g $CONFIG_FILE; }
[ $( grep -i "unimus.access.key=" $CONFIG_FILE | wc -l ) -eq 0 ] && { echo "unimus.access.key=" >> $CONFIG_FILE; }
[ ! -z $UNIMUS_SERVER_ACCESS_KEY ] && { sed -i s@unimus.access.key=.*@unimus.access.key=$UNIMUS_SERVER_ACCESS_KEY@g $CONFIG_FILE; }

# run
java $JAVA_EXTRA_PARAMS -jar /opt/unimus-core.jar
