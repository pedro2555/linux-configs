#!/bin/bash

# check if running as sudo
ROOT_UID="0"
if [ "$UID" -ne "$ROOT_UID" ] ; then
	echo "Please run as sudo (NOT root)!"
	exit 1
fi

func=""
# validate arguments
while getopts ci option
do
    case "$option" in
        c)
			shift $(($OPTIND-1))
			source ./create.sh $1 
		;;
        i)
			shift $(($OPTIND-1))
			source s./install.sh $1
		;;
    esac
done
