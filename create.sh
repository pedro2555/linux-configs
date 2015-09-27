#!/bin/bash

# check arguments
if [ "$*" == "" ]; then
    echo "No arguments provided."
    exit 1
else
	FOLDER=${1%/}

	if [ -d $FOLDER ]; then
		echo "Invalid argument: folder must not already exist."
	fi

	mkdir $FOLDER
	touch $FOLDER"/ppas"
	touch $FOLDER"/pre-update.sh"
	echo "#!/bin/bash" >> $FOLDER"/pre-update.sh"
	touch $FOLDER"/pre-install.sh"
	echo "#!/bin/bash" >> $FOLDER"/pre-install.sh"
	touch $FOLDER"/installs"
	touch $FOLDER"/post-install.sh"
	echo "#!/bin/bash" >> $FOLDER"/post-install.sh"
fi
