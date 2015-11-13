# WSO2 Development Server Box

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


If you have the jar and zip files previously downloaded, just place your files under %VM_VAGRANT_HOME%/_downloads/

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

## Servers included

The servers installed and configured are:

### WSO2 AM (back tier)
* Offset: +0
* Hostname: wso2am02a
* Version: wso2am-1.8.0
* URL: https://localhost:9443/carbon
* Gateway, Key Manager, Publisher and Store are placed in the back tier.

### WSO2 ESB (front tier)
* Offset: +6
* Hostname: wso2esb01a
* Version: wso2esb-4.8.1
* URL: https://localhost:9449/carbon
* The node is placed in front tier and should be used to do validations (JSON and XSD schemas)

### WSO2 DSS (front tier)
* Offset: +3
* Hostname: wso2dss01a
* Version: wso2dss-3.5.0
* URL: https://localhost:9446/carbon
* The node is placed in front tier

### WSO2 GREG (front tier)
* Offset: +8
* Hostname: wso2greg01a
* Version: wso2greg-5.1.0
* URL: https://localhost:9451/carbon
* The node is placed in front tier and is used as registry to store artifacts and configurations.

### WSO2 ESB (back tier)
* Offset: +2
* Hostname: wso2esb02a
* Version: wso2esb-4.8.1
* URL: https://localhost:9445/carbon
* The node is placed in back tier and should be used to do transformations (JSON to XML, XML to JSON, etc.)

### Wiremock (as backend)
* Port: 7788
* Hostname: wiremock
* Version: 1.57-standalone
* URL: http://localhost:7788/__admin
* Useful to implement mock services (REST and SOAP)


## Details about the installed servers

- The servers are installed under the `/opt/` folder.
- The init.d scripts were copied under `/etc/inid.d/` folder.
- The WSO2 Administrator username and password are `admin/admin`.


## Getting starting with VM

1. Download the VM

```
$ mkdir -p ~/github-repo/vagrant/
$ git clone https://github.com/Chilcano/vagrant/wso2-dev-srv.git
$ cd ~/github-repo/vagrant/wso2-dev-srv
```

2. Start the VM

```
$ vagrant up
```

3. Stop, reload and re/provisioning

```
$ vagrant halt
$ vagrant reload
$ vagrant provision
$ vagrant reload --provision
```

4. SSH access to the VM

```
$ vagrant ssh
```

## Starting the WSO2 servers


1. When starting the first time any WSO2 server, you have to run this command in your VM with user `vagrant`:

```
$ vagrant ssh 

...

$ ./opt/%WSO2_SERVER_NAME%/bin/wso2server.sh -Dsetup
...
[2015-11-11 07:21:20,886]  INFO - RegistryEventingServiceComponent Successfully Initialized Eventing on Registry
[2015-11-11 07:21:21,361]  INFO - JMXServerManager JMX Service URL  : service:jmx:rmi://localhost:11117/jndi/rmi://localhost:10005/jmxrmi
[2015-11-11 07:21:21,361]  INFO - StartupFinalizerServiceComponent Server           :  WSO2 Enterprise Service Bus-4.8.1
[2015-11-11 07:21:21,362]  INFO - StartupFinalizerServiceComponent WSO2 Carbon started in 24 sec
[2015-11-11 07:21:21,701]  INFO - CarbonUIServiceComponent Mgt Console URL  : https://192.168.11.20:9449/carbon/
```

Repeat this process replacing `%WSO2_SERVER_NAME%` for:
* `wso2am02a`
* `wso2esb01`
* `wso2esb02`
* `wso2dss01a`
* `wso2greg01a`

To close the running server, just CTRL+C in the shell console where the server is running.


2. The next times when you want to start the WSO2 servers, I recommend to use the init.d scripts:

```
$ sudo service %WSO2_SERVER_NAME% start|stop|restart
```

Repeat this process replacing `%WSO2_SERVER_NAME%` for:
* `wso2am02a`
* `wso2esb01`
* `wso2esb02`
* `wso2dss01a`
* `wso2greg01a`


3. For Wiremock

```
$ sudo service wiremock start|stop|restart
```


## Enabling linux services to start automatically

All WSO2 servers and Wiremock can start automatically, to do that, just apply `defaults` or `enable` to the run levels for the init.d script:

```
$ sudo update-rc.d %WSO2_SERVER_NAME% defaults
$ sudo update-rc.d %WSO2_SERVER_NAME% enable
$ sudo update-rc.d %WSO2_SERVER_NAME% disable
```

Where `%WSO2_SERVER_NAME%` could be:
* `wso2am02a`
* `wso2esb01`
* `wso2esb02`
* `wso2dss01a`
* `wso2greg01a`

Now, if you reboot the VM, the `%WSO2_SERVER_NAME%` will start too.

## Updates

- 2015.11.13: Added the rTail puppet module to collect, correlate, track and visualize all WSO2 logs using a browser.

<img src="https://github.com/Chilcano/box-vagrant-wso2-dev-srv/blob/master/_downloads/chilcano-box-vagrant-wso2-dev-srv-rtail-logs.png" width="100" alt="rTail to collect and visualize all WSO2 logs from a Browser"/>

## TODO

- Load balancing and Virtual Hosts/IPs (HA Proxy or nginx)
- Custom HealthCheck
- Correlation propagation between WSO2 servers and Backend 
- Collection, aggregation and trailing of all logs in real time (log.io, ELK, Clarity, rTail, Tailon, frontail, ufff.. there are many tools out there... )
- Monitoring (Riemann, Jolokia, CollectD/Graphite, Grafana, ...)
- Custom Mediators (Authentication, Authorization, Logging, Correlation, Common Validations and Transformations)
- WSO2 services patterns deployed as samples
- Migrate to Docker


## Resources

- Puppet 3.4.3 (http://docs.puppetlabs.com/references/3.4.latest)
- Enabling future parser in Puppet (http://blog.bluemalkin.net/iteration-in-puppet-using-the-future-parser)
- Other nice Vagrant Box with WSO2 (https://github.com/eristoddle/vagrant-wso2-box)
- How to Create a Vagrant Base Box from an Existing One (https://scotch.io/tutorials/how-to-create-a-vagrant-base-box-from-an-existing-one)
- Official WSO2 Documentation (https://docs.wso2.com)
- Vagrant Tip: Sync VirtualBox Guest Additions (http://kvz.io/blog/2013/01/16/vagrant-tip-keep-virtualbox-guest-additions-in-sync)

## Troubleshooting

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


[main]
...
parser = future

[master]
....
```

After that, restart your VM.


3.- `here your issue`

```
Drop me an message at chilcano =at= intix.info
```
