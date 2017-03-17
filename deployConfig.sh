#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
USAGE="Usage: config [create|update|delete|sync]"
PROFILE="<profile name>"
ORG="<org name>"
ENV="<env name>"
USERNAME="<username>"
PASSWORD="<password>"
OPTIONS="-e" # -e for errors, -q for quiet, -X for debug

if [ -z "$1" ]; then
	echo $USAGE
	exit 1
fi

if [ $1 -ne "create" ] && [ $1 -ne "update" ] && [ $1 -ne "delete" ] && [ $1 -ne "sync" ]; then
	echo $USAGE
	exit 1
fi

cd $BASEDIR/config
echo $(pwd)
echo "Starting env config ..."
mvn install $OPTIONS -P$PROFILE -Dusername=$USERNAME -Dpassword=$PASSWORD -Dorg=$ORG -Denv=$ENV -Dapigee.config.options=$1
echo "... done"
