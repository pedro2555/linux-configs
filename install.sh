#!/bin/bash

#
# Run initialization checks and requests
#

# check arguments
if [ "$*" == "" ]; then
    echo "No arguments provided."
    exit 1
fi
distribution="$(dirname "$1")"
distribution=${distribution%/}
machine=${1%/}

# check if folder and parent contain either a installs or ppas file, or both
if [[ ! -f $distribution"/ppas" && ! -f $distribution"/installs" ]]; then
	echo "Invalid argument: parent folder must contain either a file named ppas, a file named installs, or both."
	exit 1
fi
if [[ ! -f $machine"/ppas" && ! -f $machine"/installs" ]]; then
	echo "Invalid argument: folder must contain either a file named ppas, a file named installs, or both."
	exit 1
fi

#
# Deal with ppa additions, and pre-update scripts
#
# Load ppas files
echo -e "\e[33mLoading package libraries...\e[39m"
declare -a ppas
let i=0
if [ -f $machine"/ppas" ]; then
	while IFS=$'\n' read -r line_data; do
	    ppas[i]="${line_data}"
	    ((++i))
	done < $machine"/ppas"
fi
if [ -f $distribution"/ppas" ]; then
	while IFS=$'\n' read -r line_data; do
	    ppas[i]="${line_data}"
	    ((++i))
	done < $distribution"/ppas"
fi
if [ ${#ppas[@]} -ne 0 ]; then
	echo -e "\e[33mConfirm trought the PPA addition\e[39m"

	for ppa in ${ppas[@]}; do>&1
		add-apt-repository $ppa
	done
fi
# run pre-update scripts
echo -e "\e[33mRunning pre-update scripts...\e[39m"
if [ $machine"/pre-update.sh" ]; then
	$machine"/pre-update.sh"
fi
if [ $distribution"/pre-update.sh" ]; then
	source $distribution"/pre-update.sh"
fi
# update package libraries and upgrade
echo -e "\e[33mUpdating package libraries and upgrading...\e[39m"
#apt-get update > /dev/null
#apt-get upgrade > /dev/null


#
# Deal with pre-install scripts, packages installation, post-install scripts, and package upgrade
#
# run pre-install scripts
echo -e "\e[33mRunning pre-install scripts...\e[39m"
if [ -f $machine"/pre-install.sh" ]; then
	source $machine"/pre-install.sh"
fi
if [ -f $distribution"/pre-install.sh" ]; then
	source $distribution"/pre-install.sh"
fi
# Load package names
echo -e "\e[33mLoading and installing packages...\e[39m"
declare -a installs
let i=0
if [ -f $machine"/installs" ]; then
	while IFS=$'\n' read -r line_data; do
	    installs[i]="${line_data}"
	    ((++i))
	done < $machine"/installs"
fi
if [ -f $distribution"/installs" ]; then
	while IFS=$'\n' read -r line_data; do
	    installs[i]="${line_data}"
	    ((++i))
	done < $distribution"/installs"
fi
# install packages
echo -e "\e[33mInstalling package(s)...\e[39m"
if [ ${#packages[@]} -ne 0 ]; then

	for i in ${packages[@]}; do
		apt-get	install $i > /dev/null
		echo -e "\e[96m$i\e[39m"
	done
	#apt-get upgrade > /dev/null
fi
# run post-install scripts
echo -e "\e[33mRunning post-install scripts...\e[39m"
if [ -f $machine"/post-install.sh" ]; then
	source $machine"/post-install.sh"
fi
if [ -f $distribution"/post-install.sh" ]; then
	source $distribution "/post-install.sh"
fi
