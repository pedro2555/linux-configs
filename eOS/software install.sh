#
# PPAs
#
# Braseo
sudo add-apt-repository ppa:renbag/ppa
# TLP
sudo add-apt-repository ppa:linrunner/tlp
# eOS tweaks
sudo add-apt-repository ppa:mpstark/elementary-tweaks-daily
# caffeine
sudo apt-add-repository ppa:behda/ppa
# Oracle's Virtual Box
sudo touch /etc/apt/sources.list.d/vbox.list
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian quantal contrib" >> /etc/apt/sources.list.d/vbox.list'


sudo apt-get update

#
# Installations
#

# Ads blocking
sudo wget http://winhelp2002.mvps.org/hosts.txt --output-document=/etc/hosts

# Productivity
sudo apt-get install vim
sudo apt-get install git
sudo apt-get install giggle

# Web
sudo apt-get install chromium-browser
sudo apt-get install filezilla
sudo apt-get install apache2
sudo apt-get install php5
sudo apt-get install mysql-server

# Media
sudo apt-get install vlc

# Utilities
# Disks utility
sudo apt-get install gnome-disk-utility
# System monitor app
sudo apt-get install gnome-system-monitor
# CD/DVD burner
sudo apt-get install brasero
# Backup settings
sudo apt-get install deja-dup
# Commonly used libraries
sudo apt-get install ubuntu-restricted-extras
# Battery reduce
sudo apt-get install tlp tlp-rdw
# eOS tweaks
sudo apt-get install elementary-tweaks
# uGet download manager
sudo apt-get install uget
# virtualization suite
sudo apt-get install virtualbox-4.3
# gnome sound converter
sudo apt-get install soundconverter
# GNU Cash
sudo apt-get install gnucash
# caffeine, to manually prevent sleeping/locking on idle
sudo apt-get install caffeine


#
# Configurations
#
# power saving settings
sudo tlp start
# change default text based editor (3 for vim)
sudo update-alternatives --config editor
# change apache root to /var/www and remove default apache page
sudo sed -i '/DocumentRoot/c\        DocumentRoot /var/www' /etc/apache2/sites-enabled/000-default.conf 
sudo rm -rf /var/www
sudo mkdir /var/www
sudo chgrp www-data /var/www/
sudo chmod g+w /var/www/
sudo service apache2 restart

