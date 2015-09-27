#!/bin/bash

# check if running as sudo
ROOT_UID="0"
if [ "$UID" -ne "$ROOT_UID" ] ; then
	echo "Please run as sudo (NOT root)!"
	exit 1
fi

func=""
# validate arguments
while getopts ci: option
do
    case "$option" in
        c) func="c" ;;
        i) func="i" ;;
        o);;
    esac
done
shift $(($OPTIND-1))
FOLDER="$1"

case "$func" in
	c) source ./create.sh $FOLDER ;;
	i) source ./install.sh $FOLDER ;;
esac