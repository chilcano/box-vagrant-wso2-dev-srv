#!/bin/sh

# ========================================================================================== #
# Add/increase Swap partition. Tested with ubuntu/trusty64                                   #
#                                                                                            #
# Link 1: https://gist.github.com/shovon/9dd8d2d1a556b8bf9c82                                #
# Link 2: https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-12-04   #
# ========================================================================================== #

# Size of swapfile in megabytes
swapsize=8000

# Does the swap file already exist?
grep -q "swapfile" /etc/fstab

# If not then create it
if [ $? -ne 0 ]; then
  echo 'swapfile not found. Adding swapfile.'
  fallocate -l ${swapsize}M /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap defaults 0 0' >> /etc/fstab
else
  echo 'swapfile found. No changes made.'
fi

# Output results to terminal
df -h
cat /proc/swaps
cat /proc/meminfo | grep Swap