#!/bin/bash


#
# Run initialization checks and requests
#
# check if running as sudo
ROOT_UID="0"
if [ "$UID" -ne "$ROOT_UID" ] ; then
	echo "Please run as sudo (NOT root)!"
	exit 1
fi
# get distribution
echo -e "\e[33mSelect a distribution:\e[39m"
select distribution in */; do test -n "$distribution" && break; echo ">>> Invalid Selection"; done
cd "$distribution"
# get machine
echo -e "\e[33mSelect a machine:\e[39m"
select machine in */; do test -n "$machine" && break; echo ">>> Invalid Selection"; done
cd ..


#
# Deal with ppa additions, and pre-update scripts
#
# Load ppas files
echo -e "\e[33mLoading package libraries...\e[39m"
declare -a ppas
let i=0
if [ -f $distribution$machine"ppas" ]; then
	while IFS=$'\n' read -r line_data; do
	    ppas[i]="${line_data}"
	    ((++i))
	done < $distribution$machine"ppas"
fi [ -f $distribution"ppas" ]; then
	while IFS=$'\n' read -r line_data; do
	    ppas[i]="${line_data}"
	    ((++i))
	done < $distribution"ppas"
fi
if [ ${#ppas[@]} -ne 0 ]; then
	echo -e "\e[33mConfirm trought the PPA addition\e[39m"

	for ppa in ${ppas[@]}; do>&1
		add-apt-repository $ppa
	done
fi
# run pre-update scripts
echo -e "\e[33mRunning pre-update scripts...\e[39m"
if [ -f $distribution$machine"pre-update.sh" ]; then
	source $distribution$machine"pre-update.sh"
fi
if [ -f $distribution$machine"pre-update.sh" ]; then
	source $distribution "pre-update.sh"
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
if [ -f $distribution$machine"pre-install.sh" ]; then
	source $distribution$machine"pre-install.sh"
fi
if [ -f $distribution$machine"pre-install.sh" ]; then
	source $distribution "pre-install.sh"
fi
# Load package names
echo -e "\e[33mLoading and installing packages...\e[39m"
declare -a installs
let i=0
fi [ -f $distribution$machine"installs" ]; then
	while IFS=$'\n' read -r line_data; do
	    installs[i]="${line_data}"
	    ((++i))
	done < $distribution$machine"installs"
fi
fi [ -f $distribution"installs" ]; then
	while IFS=$'\n' read -r line_data; do
	    installs[i]="${line_data}"
	    ((++i))
	done < $distribution"installs"
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
if [ -f $distribution$machine"post-install.sh" ]; then
	source $distribution$machine"post-install.sh"
fi
if [ -f $distribution$machine"post-install.sh" ]; then
	source $distribution "post-install.sh"
fi
