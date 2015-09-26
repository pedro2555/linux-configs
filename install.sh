#!/bin/bash

#Check if run as root
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

# get packages folders

# load all package install names, ppas, and configs from folder packages/
echo -e "\e[33mLoading packages ...\e[39m"
declare -A ppas
declare -A packages
declare -A configs
ppas_id=0
packages_id=0
configs_id=0

for f in $distribution*.cfg ; do
	echo $f
	source $f

	if [ "$ppa" ] ; then
		ppas[$ppas_id]=$ppa
		let ppas_id=$ppas_id+1
	fi
	if [ "$install" ] ; then
		packages[$packages_id]=$install
		let packages_id=$packages_id+1
	fi
	if [ "$config" ] ; then
		configs[$configs_id]=$config
		let configs_id=$configs_id+1
	fi
	unset ppa
	unset install
	unset config
done
echo ${#ppas[@]}

read

# import all loaded PPAs
echo -e "\e[32mLoaded ${#packages[@]} package(s).\e[39m"
echo ''
echo ''
if [ ${#ppas[@]} -ne 0 ]; then
	echo -e "\e[33mConfirm trought the PPA addition\e[39m"

	for ppa in ${ppas[@]}; do>&1
		add-apt-repository $ppa
	done
	echo -e "\e[33mUpdating package libraries...\e[39m"
	#apt-get update > /dev/null
	echo -e "\e[32mFinished updating package libraries.\e[39m"
	echo ''
	echo ''
fi

# install all loaded packages
if [ ${#packages[@]} -ne 0 ]; then
	echo -e "\e[33mInstalling package(s)...\e[39m"

	for i in ${packages[@]}; do
		apt-get	install $i > /dev/null
		echo -e "\e[96m$i\e[39m"
	done

	echo -e "\e[32mFinished installing package(s).\e[39m"
	echo ''
	echo ''
fi

# run all required configurations
if [ ${#configs[@]} -ne 0 ]; then
	echo ${#configs[@]}
	echo -e "\e[33mRunning package(s) configuration(s)...\e[39m"

	for ((i = 0; i < ${#configs[@]}; i++)); do
	    ${configs[$i]}
	done

	echo -e "\e[32mFinished running package(s) configuration(s).\e[39m"
	echo ''
	echo ''
fi