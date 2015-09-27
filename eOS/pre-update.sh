#!/bin/bash

touch /etc/apt/sources.list.d/vbox.list
sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian quantal contrib" >> /etc/apt/sources.list.d/vbox.list'

wget http://winhelp2002.mvps.org/hosts.txt --output-document=/etc/hosts