# Vagrant WSO2 Development Server Box

> This Vagrant box was the older [box-vagrant-wso2-dev-srv](https://holisticsecurity.wordpress.com/2015/11/11/creating-a-vm-with-wso2-servers-for-development).
> I have removed the rTail Puppet modules to create a new rTail server Docker Container.
> The older GitHub repository for [box-vagrant-wso2-dev-srv](https://holisticsecurity.wordpress.com/2015/11/11/creating-a-vm-with-wso2-servers-for-development) will not be updated.
> I recommend you using this new one, more lightweight and flexible.


This VM is suitable to develop with WSO2 products and puts focus only in the `server side` (WSO2 servers, mock server and different tools to host our micro/services) and not in `desktop side` (Eclipse, SoapUI, Maven, etc.).
The main objetive is to have a VM with all WSO2 products installed and configured to be ready for development and following the most common Middleware infrastructure pattern used to create (Micro)services.
The `naming` used in `hostnames` tries to use pre-defined values what also will be used in Integration and Production Environments. The `ports` and `offsets` used do not follow any special rule.

![WSO2 Development Server Map](https://github.com/Chilcano/box-vagrant-wso2-dev-srv/blob/master/_downloads/chilcano-box-vagrant-wso2-dev-srv-map.png "WSO2 Development Server Map")

This VM tries to implement 2 tiers for the middleware and they are:

**Front tier**
- In the first tier are mainly are located a first instance of WSO2 ESB.
- The purpose of this instance of WSO2 ESB is to implement all type of `validations` as JSON Schema, XSD Schema, etc.
- WSO2 Governance Registry and WSO2 Data Service Server also have been placed in this tier.

**Back tier**
- The second tier where mainly is placed a second instance of WSO2 ESB. 
- The purpose of this instance is to implement all type of `transformations` as from XML to JSON, from JSON to XML, etc.
- Altough WSO2 AM has different deployment patterns and WSO2 AM (Gateway) should be in the front tier, I have placed WSO2 AM (Gateway, Publisher, Store and Key Manager) in this tier.

**The Backend**
- I wanna use Wiremock as mock server to implement REST and SOAP services.


If you have the jar and zip files previously downloaded, just place your files under `%VM_VAGRANT_HOME%/_downloads/`

My directory structure looks like:

```
%VM_VAGRANT_HOME%/_downloads/
%VM_VAGRANT_HOME%/_downloads/postgresql-9.4-1201.jdbc41.jar
%VM_VAGRANT_HOME%/_downloads/wiremock-1.57-standalone.jar
%VM_VAGRANT_HOME%/_downloads/wso2am-1.8.0.zip
%VM_VAGRANT_HOME%/_downloads/wso2dss-3.5.0.zip
%VM_VAGRANT_HOME%/_downloads/wso2esb-4.8.1.zip
%VM_VAGRANT_HOME%/_downloads/wso2greg-5.1.0.zip
%VM_VAGRANT_HOME%/provision/
%VM_VAGRANT_HOME%/provision/wso2-stack-srv/
%VM_VAGRANT_HOME%/provision/wso2-stack-srv/puppet/
%VM_VAGRANT_HOME%/provision/wso2-stack-srv/shell/
%VM_VAGRANT_HOME%/readme.MD
%VM_VAGRANT_HOME%/Vagrantfile
```

## 1. Servers/products included in this Vagrant box

The servers installed and configured are:

__WSO2 AM (back tier)__
* Offset: +0
* Hostname: wso2am02a
* Version: wso2am-1.8.0
* URL: [https://localhost:9443/carbon](https://localhost:9443/carbon)
* Gateway, Key Manager, Publisher and Store are placed in the back tier.

__WSO2 ESB (front tier)__
* Offset: +6
* Hostname: wso2esb01a
* Version: wso2esb-4.8.1
* URL: [https://localhost:9449/carbon](https://localhost:9449/carbon)
* The node is placed in front tier and should be used to do validations (JSON and XSD schemas)

__WSO2 DSS (front tier)__
* Offset: +3
* Hostname: wso2dss01a
* Version: wso2dss-3.5.0
* URL: [https://localhost:9446/carbon](https://localhost:9446/carbon)
* The node is placed in front tier

__WSO2 GREG (front tier)__
* Offset: +8
* Hostname: wso2greg01a
* Version: wso2greg-5.1.0
* URL: [https://localhost:9451/carbon](https://localhost:9451/carbon)
* The node is placed in front tier and is used as registry to store artifacts and configurations.

__WSO2 ESB (back tier)__
* Offset: +2
* Hostname: wso2esb02a
* Version: wso2esb-4.8.1
* URL: [https://localhost:9445/carbon](https://localhost:9445/carbon)
* The node is placed in back tier and should be used to do transformations (JSON to XML, XML to JSON, etc.)

__Wiremock (as backend)__
* Port: 7788
* Hostname: wiremock
* Version: 1.57-standalone
* URL: [http://localhost:7788/__admin](http://localhost:7788/__admin)
* Useful to implement mock services (REST and SOAP)

### Details about the installed servers

- The servers are installed under the `/opt/` folder.
- The init.d scripts were copied under `/etc/inid.d/` folder.
- The WSO2 Administrator username and password are `admin/admin`.


## 2. Getting starting

__1) Download the Vagrant scripts__

```
$ git clone https://github.com/chilcano/vagrant-wso2-dev-srv.git
$ cd ~/github-repo/vagrant-wso2-dev-srv
```

__2) Start the Vagrant box__

The first time this process will take long time becuase the ISO Linux image and the WSO2 and required software have to be downloaded, unzipped and installed.

```
$ vagrant up
```

__3) Stop, reload and re/provisioning__


To stop the Vagrant box.
```bash
$ vagrant halt
```


If you modify the Puppet scrips or change or open more ports, then you have to start with the flag `provision` and `reload` enabled, or both enabled.
```bash
$ vagrant reload
$ vagrant provision
```

Reload and provision.
```bash
$ vagrant reload --provision
```

__4) Get SSH access to the Vagrant box__

```
$ vagrant ssh
```


## 3. Starting the WSO2 servers and Wiremock


__1) Starting the WSO2 servers__

When starting the first time any WSO2 server, you have to start it by running with this command `wso2server.sh -Dsetup` and using the user `vagrant`.
With the `-Dsetup` flag, WSO2 will initialize the local/internal Database and will populate with a few data.

```bash
$ ./opt/%WSO2_SERVER_NAME%/bin/wso2server.sh -Dsetup
...
[2015-11-11 07:21:20,886]  INFO - RegistryEventingServiceComponent Successfully Initialized Eventing on Registry
[2015-11-11 07:21:21,361]  INFO - JMXServerManager JMX Service URL  : service:jmx:rmi://localhost:11117/jndi/rmi://localhost:10005/jmxrmi
[2015-11-11 07:21:21,361]  INFO - StartupFinalizerServiceComponent Server           :  WSO2 Enterprise Service Bus-4.8.1
[2015-11-11 07:21:21,362]  INFO - StartupFinalizerServiceComponent WSO2 Carbon started in 24 sec
[2015-11-11 07:21:21,701]  INFO - CarbonUIServiceComponent Mgt Console URL  : https://192.168.11.20:9449/carbon/
```

Repeat this process for each WSO2 instance by replacing `%WSO2_SERVER_NAME%` for:
* `wso2am02a`
* `wso2esb01`
* `wso2esb02`
* `wso2dss01a`
* `wso2greg01a` 

To close the running server, just `CTRL+C` in the shell console where the server is running, this will release the shell console.


__2) Starting WSO2 the next time__

The next times when starting the WSO2 servers, I recommend to use the `init.d` scripts already created instead of `wso2server.sh` directly.
Using these `init.d` scripts the WSO2 instances will start as a Linux service and will create `pid` and `lock` files.


```bash
$ sudo service %WSO2_SERVER_NAME% start|stop|restart|status
```

The `init.d` scripts available in `/etc/init.d/` match with the name of WSO2 and Wiremock instances and they are:
* `wso2am02a`
* `wso2esb01`
* `wso2esb02`
* `wso2dss01a`
* `wso2greg01a`
* `wiremock`



## 4. Enabling linux services to start automatically

I have faced some troubles using `init.d` scripts in this Vagrant box (probably is because it is based on Ubuntu image) where I have lost the control of every server when starting, reloading and provisioning thi Vagrant box, for this reason I recommend you do not enable the services to start automatically on boot up.

I have removed the Puppet scripts to enable this functionality, but if you want do it, below are the commands:
```bash
$ sudo update-rc.d %WSO2_SERVER_NAME% defaults
```
Or
```bash
$ sudo update-rc.d %WSO2_SERVER_NAME% enable
```

To disable it, just execute the next command:
```bash
$ sudo update-rc.d %WSO2_SERVER_NAME% disable
```

To remove completly, but after that make sure to restart the Vagrant image:
```bash
$ sudo update-rc.d %WSO2_SERVER_NAME% remove
```

To check what Linux services are running or enabled, just execute this in your VM:
```bash
$ service --status-all
 ...
 [ + ]  wiremock
 [ - ]  wso2am02a
 [ - ]  wso2dss01a
 [ - ]  wso2esb01a
 [ - ]  wso2esb02a
 [ - ]  wso2greg01a
 ...
```


## 5. Monitoring the (Micro)services: Logging

Check out these posts:

- https://holisticsecurity.wordpress.com/2015/11/20/rtail-a-tool-to-collect-and-view-the-wso2-logs-in-a-browser
- https://holisticsecurity.wordpress.com/2016/01/19/log-events-management-wso2-microservices-elk-rtail-part-i


## 6. Monitoring the Infrastructure

_Soon I will use one of them: Riemann, Jolokia, CollectD/Graphite, Grafana, etc...._


## 7. Deploying WSO2 C-App (car files) from Maven

_Soon I will post further details how to do that._


## 8. TODO

- Load balancing and Virtual Hosts/IPs (HA Proxy or nginx)
- Custom HealthCheck
- Correlation propagation between WSO2 servers and Backend 
- Custom Mediators (Authentication, Authorization, Logging, Correlation, Common Validations and Transformations)
- ~~WSO2 services patterns deployed as samples~~ (Check It here: https://github.com/chilcano/wso2-ei-patterns)
- ~~Docker~~ (Check It here: https://holisticsecurity.wordpress.com/2016/01/11/strategy-to-create-microservices-using-wso2-and-docker)


## 9. Resources

- Puppet 3.4.3 (http://docs.puppetlabs.com/references/3.4.latest)
- Enabling future parser in Puppet (http://blog.bluemalkin.net/iteration-in-puppet-using-the-future-parser)
- Other nice Vagrant Box with WSO2 (https://github.com/eristoddle/vagrant-wso2-box)
- How to Create a Vagrant Base Box from an Existing One (https://scotch.io/tutorials/how-to-create-a-vagrant-base-box-from-an-existing-one)
- Official WSO2 Documentation (https://docs.wso2.com)
- Vagrant Tip: Sync VirtualBox Guest Additions (http://kvz.io/blog/2013/01/16/vagrant-tip-keep-virtualbox-guest-additions-in-sync)


## 10. Troubleshooting

1.- `Error: Cannot allocate memory - fork(2)`

This is because there isn't space in the swap partition or there isn't swap partition.

```
$ vagrant ssh
$ free -m

             total       used       free     shared    buffers     cached
Mem:          4038       2551       1487          0         13        195
-/+ buffers/cache:       2342       1696
Swap:
```
Follow this instructions to solve it: https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-12-04

2.- `Error: Syntax error at '.'; expected '}'`.

This is because Puppet hasn't enable the `future parser`. 

```
==> wso2srv: Error: Syntax error at '.'; expected '}' at /tmp/vagrant-puppet/modules-7649381c00c1b064b7b0aaf106eac610/wso2esb/manifests/copy_files.pp:12 on node wso2-dev-srv-01.local
```
To enable `future parser`in Puppet, just add this line `parser = future` to `/etc/puppet/puppet.conf`

```
$ sudo nano /etc/puppet/puppet.conf
```

```
[main]
...
parser = future

[master]
....
```

After that, restart your VM.


3.- Vagrant can't mouth folders (`Failed to mount folders in Linux guest. This is usually because ...`)

Has been reported a bug in VirtualBox Guest Additions 4.3.10 where is not possible mount folders. For this reason, Vagrant can not share folders between guest and host. 
Further details here: [https://www.virtualbox.org/ticket/12879](https://www.virtualbox.org/ticket/12879)

I have created a guide for you to fix that: [_downloads/vagrant-vboxguestadditions-workaroud.md](_downloads/vagrant-vboxguestadditions-workaroud.md)


4.- `here your issue`

```
Drop me a message here chilcano =at= intix.info
```
