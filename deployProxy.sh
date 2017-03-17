#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
USAGE="Usage: install [<proxy name>|all] [clean|update|new]"
PROFILE="<profile name>"
ORG="<org name>"
ENV="<env name>"
USERNAME="<username>"
PASSWORD="<password>"
OPTIONS="-e" # -e for errors, -q for quiet, -X for debug

declare -a PROXIES=("import-token" "import-token-test")


if [ -z "$1" ] || [ -z "$2" ]; then
	echo $USAGE
	exit 1
fi

if [ "$1" = "all" ]; then

	for proxy in "${PROXIES[@]}"
	do
	  cd $BASEDIR/src/gateway/"$proxy"
	  echo $(pwd)
	  echo "Deploying proxy $proxy"

		if [ "$2" = "clean" ]; then
			mvn clean $OPTIONS
		elif [ "$2" = "update" ]; then
	  	mvn install $OPTIONS -P$PROFILE -Dusername=$USERNAME -Dpassword=$PASSWORD -Dorg=$ORG -Denv=$ENV -Doptions=validate,update
		elif [ "$2" = "new" ]; then
	  	mvn install $OPTIONS -P$PROFILE -Dusername=$USERNAME -Dpassword=$PASSWORD -Dorg=$ORG -Denv=$ENV
		fi
	done
	exit 0;

else

	cd $BASEDIR/src/gateway/"$1"
	echo $(pwd)
	echo "Deploying proxy $1"

	if [ "$2" = "clean" ]; then
		mvn clean $OPTIONS
	elif [ "$2" = "update" ]; then
  	mvn install $OPTIONS -P$PROFILE -Dusername=$USERNAME -Dpassword=$PASSWORD -Dorg=$ORG -Denv=$ENV -Doptions=validate,update
	elif [ "$2" = "new" ]; then
  	mvn install $OPTIONS -P$PROFILE -Dusername=$USERNAME -Dpassword=$PASSWORD -Dorg=$ORG -Denv=$ENV
	fi
	exit 0;

fi


