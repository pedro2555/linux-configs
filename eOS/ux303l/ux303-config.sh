#
# PPAs
#

# Touchpad
sudo add-apt-repository ppa:hanipouspilot/focaltech-dkms
# Brightness indicator
sudo add-apt-repository ppa:indicator-brightness/ppa

# update and upgrade
sudo apt-get update
sudo apt-get upgrade

#
#  Install Packages
#

# vivid's kernel, for touchpad drives
sudo apt-get install linux-generic-lts-vivid
# Focaltech's touchpad dirver
sudo apt-get install focaltech-dkms
# brightness indicator
sudo apt-get install indicator-brightness
# backlight
# xrandr --output eDP1 --brightness (.0-1)
# CPU freq, for performance-powersave options
sudo apt-get install indicator-cpufreq

#
# Configurations
#
# enable Bluetooth
rfkill unblock bluetooth

