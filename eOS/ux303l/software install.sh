#
# PPAs
#
# Braseo
sudo add-apt-repository ppa:renbag/ppa
# TLP
sudo add-apt-repository ppa:linrunner/tlp
# eOS tweaks
sudo add-apt-repository ppa:mpstark/elementary-tweaks-daily

sudo apt-get update

#
# Installations
#

# Productivity
sudo apt-get install vim
sudo apt-get install git
sudo apt-get install giggle

# Web
sudo apt-get install chromium-browser

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
sudo apt-get install virtualbox

#
# Configurations
#
# power saving settings
sudo tlp start
# change default text based editor (3 for vim)
sudo update-alternatives --config editor


