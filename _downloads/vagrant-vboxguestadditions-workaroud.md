How to install the VirtualBox Guest Additions manually in a Vagrant box
========================================================================


__1) Download the VirtualBox Additions ISO (4.3.10)__

```
$ wget http://download.virtualbox.org/virtualbox/4.3.10/VBoxGuestAdditions_4.3.10.iso
```

__2) Mount the ISO in your Guest box__

```
$ vagrant halt
```

And from VBox GUI, add ISO file in new CD/DVD media.

__3) Install VBoxGuestAdditions in your Guest box__

Uninstall the plugin vagrant-vbguest:
```
$ vagrant plugin install vagrant-vbguest
```

Start the Guest box:
```
$ vagrant up
```

Identify the CD/DVD media:
```
$ sudo blkid
/dev/sr0: LABEL="VBOXADDITIONS_4.3.10_93012" TYPE="iso9660" 

Mount the ISO
$ mkdir /media/cdrom
$ sudo mount /dev/sr0 /media/cdrom/
$ cd /media/cdrom
$ ls
32Bit        cert                    VBoxSolarisAdditions.pkg
64Bit        OS2                     VBoxWindowsAdditions-amd64.exe
AUTORUN.INF  runasroot.sh            VBoxWindowsAdditions.exe
autorun.sh   VBoxLinuxAdditions.run  VBoxWindowsAdditions-x86.exe
```

Execute VBoxLinuxAdditions.run to install VBoxGuestAdditions:
```
$ ./VBoxLinuxAdditions.run
```

__4) Check the installation__

```
$ ls -la /opt/VBoxGuestAdditions-4.3.10/
total 80
drwxr-xr-x  9 root root  4096 Nov 18 18:18 ./
drwxr-xr-x 10 root root  4096 Nov 18 18:29 ../
drwxr-xr-x  2 root root  4096 Mar 26  2014 bin/
drwxr-xr-x  2 root root  4096 Mar 26  2014 init/
drwxr-xr-x  2 root root  4096 Nov 18 18:17 installer/
drwxr-xr-x  3 root root  4096 Mar 26  2014 lib/
-rwxr-xr-x  1 root root 20137 Mar 26  2014 LICENSE*
-rwxr-xr-x  1 root root 20079 Nov 18 18:18 routines.sh*
drwxr-xr-x  2 root root  4096 Mar 26  2014 sbin/
drwxr-xr-x  3 root root  4096 Mar 26  2014 share/
drwxr-xr-x  3 root root  4096 Mar 26  2014 src/
-rwxr-xr-x  1 root root  2768 Nov 18 18:18 uninstall.sh*
```

```
$ modinfo vboxguest
filename:       /lib/modules/3.13.0-67-generic/updates/dkms/vboxguest.ko
version:        4.3.10
license:        GPL
description:    Oracle VM VirtualBox Guest Additions for Linux Module
author:         Oracle Corporation
srcversion:     FDAC0A8218FE4AEFD8732E8
alias:          pci:v000080EEd0000CAFEsv00000000sd00000000bc*sc*i*
depends:
vermagic:       3.13.0-67-generic SMP mod_unload modversions 686
```

__5) Create symlink__

```
$ sudo ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
```

6) Add new folders to share between Host and Guest

In Vagrant file I have added the next:
```
...
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty32"

  config.vm.synced_folder "_mnt_wso2esb01a/", "/opt/wso2esb01a", create: true
  config.vm.synced_folder "_mnt_wso2dss01a/", "/opt/wso2dss01a", create: true
  config.vm.synced_folder "_mnt_wiremock/", "/opt/wiremock", create: true
 ...
```

Restart Guest:

```
$ vagrant reload

...
==> wso2srv: Attempting graceful shutdown of VM...
==> wso2srv: Forcing shutdown of VM...
...
==> wso2srv: Mounting shared folders...
    wso2srv: /vagrant => /Users/Chilcano/1github-repo/box-vagrant-wso2-dev-srv
    wso2srv: /opt/wiremock => /Users/Chilcano/1github-repo/box-vagrant-wso2-dev-srv/_mnt_wiremock
    wso2srv: /opt/wso2dss01a => /Users/Chilcano/1github-repo/box-vagrant-wso2-dev-srv/_mnt_wso2dss01a
    wso2srv: /opt/wso2esb01a => /Users/Chilcano/1github-repo/box-vagrant-wso2-dev-srv/_mnt_wso2esb01a
...
==> wso2srv: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> wso2srv: flag to force provisioning. Provisioners marked to run always will still run.
```

__7) Check if everything worked__


__8) References__

- How to install Virtualbox guest additions on Ubuntu 14.04: <br/>
http://www.binarytides.com/vbox-guest-additions-ubuntu-14-04

- VirtualBox download page: <br/>
http://download.virtualbox.org/virtualbox/4.3.10/

- Can't mount shared folders with guest additions 4.3.10: <br/>
https://www.virtualbox.org/ticket/12879

- Error: vagrant failed to mount folders in Linux guest. <br/>
https://github.com/mitchellh/vagrant/issues/5503

- Vagrant error : Failed to mount folders in Linux guest. <br/>
http://stackoverflow.com/questions/22717428/vagrant-error-failed-to-mount-folders-in-linux-guest

