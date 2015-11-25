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

__rTail server (logging)__
* HTTP Port (view logs): 8181
* UDP Port (receive logs): 9191
* URL: [http://localhost:8181](http://localhost:8181)
* Useful to trail log events

### Details about the installed servers

- The servers are installed under the `/opt/` folder.
- The init.d scripts were copied under `/etc/inid.d/` folder.
- The WSO2 Administrator username and password are `admin/admin`.


## Getting starting with VM

__1) Download the VM__

```
$ mkdir -p ~/github-repo/vagrant/
$ git clone https://github.com/Chilcano/vagrant/wso2-dev-srv.git
$ cd ~/github-repo/vagrant/wso2-dev-srv
```

__2) Start the VM__

The first time this process will take long time becuase the ISO image and Software to be installed will download.

```
$ vagrant up
```

__3) Stop, reload and re/provisioning__

```
$ vagrant halt
$ vagrant reload
$ vagrant provision
```

Reload and provision:
```
$ vagrant reload --provision
```

__4) SSH access to the VM__

```
$ vagrant ssh
```

## Starting the WSO2 servers and Wiremock

1) When starting the first time any WSO2 server have to be started running this command `wso2server.sh -Dsetup` in your VM with the user `vagrant`:

```
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

To close the running server, just `CTRL+C` in the shell console where the server is running.


2) The next times when starting the WSO2 servers, I recommend to use the `init.d` scripts already created. Using these scripts the WSO2 instances will start as a Linux service.

```
$ sudo service %WSO2_SERVER_NAME% start|stop|restart
```

The WSO2 scripts available in /etc/init.d/ match with the name of WSO2 and Wiremock instances and they are:
* `wso2am02a`
* `wso2esb01`
* `wso2esb02`
* `wso2dss01a`
* `wso2greg01a`
* `wiremock`


Wiremock doesn't require to run an initial script, to start Wiremock as a Linux service just use this:

```
$ sudo service wiremock start|stop|restart
```


## Enabling linux services to start automatically

All WSO2 servers and Wiremock can start automatically when booting the VM, to do that, just apply `defaults` or `enable` to the run levels for all above `init.d` scripts:

```
$ sudo update-rc.d %WSO2_SERVER_NAME% defaults
$ sudo update-rc.d %WSO2_SERVER_NAME% enable
```

Where `%WSO2_SERVER_NAME%` could be:
* `wso2am02a`
* `wso2esb01`
* `wso2esb02`
* `wso2dss01a`
* `wso2greg01a`

The `wiremock` script doesn't require to enable to start automatically when booting because `wiremock` was already enabled using Puppet modules.

Now, if you reboot the VM, the `%WSO2_SERVER_NAME%` will start too.

If you want to disable the init.d scripts, just execute the next command:
```
$ sudo update-rc.d %WSO2_SERVER_NAME% disable
```

To check what Linux services are running, just execute this in your VM:

```
$ service --status-all
 ...
 [ + ]  rtail
 [ + ]  rtailsendlogs
 ...
 [ + ]  wiremock
 [ - ]  wso2am02a
 [ - ]  wso2dss01a
 [ - ]  wso2esb01a
 [ - ]  wso2esb02a
 [ - ]  wso2greg01a
 ...
```

## Monitoring the (Micro)services: Logging

Trailing and checking of the performance and the health of (micro)services are important tasks to be accomplished.
The logging is a time consuming process and we have to prepare before in order to be more productive.
There are many tools out there, opensource, commercial, on-cloud, such as log.io, ELK, Clarity, rTail, Tailon, frontail, etc. In my opinion, for a VM used to development the most simple, fresh and lightweight tool is rTail (http://rtail.org).

With rTail I can collect different log files, track and visualize them from a Browser in __real time__. rTail is very easy to use, just install NodeJS and deploy rTail application and you will be ready to send any type of traces to Browser directly avoiding store/persist logs, index and parse/filter them. 

### Using rTail

I have created a Puppet module for rTail and a set of scripts to collect and send traces of all WSO2 instances and Wiremock to the Browser.

Below the steps to follow:

__1) The rTail Vagrant re-provisioning__

```
$ cd ~/github-repo/box-vagrant-wso2-dev-srv
$ git pull
$ vagrant reload --provision
```

__2) Check node.js and rTail installation__

```
$ cd ~/github-repo/box-vagrant-wso2-dev-srv
$ vagrant ssh
```

```
vagrant@wso2-dev-srv-01 $ node -v
v0.10.25

vagrant@wso2-dev-srv-01 $ npm list -g rtail
/usr/local/lib
└── rtail@0.2.1
```

__3) Checking if rTail server is running__

The configuration for rTail server is:
* UDP port: 9191
* HTTP port: 8181 
* rTail home folder: `/opt/rtail`
* Script init.d for rTail server: `/etc/init.d/rtail`
* Script init.d to send all logs to rTail server: `/etc/init.d/rtailsendlogs`

Now, make sure the rTail server is running. 

```
$ service --status-all
 ...
 [ + ]  rtail
 [ + ]  rtailsendlogs
 ...

$ sudo service rtail status
[rTail] server is running (pid 1234)
```

There is a rTail Puppet module to enable the rTail server to start automatically when booting the VM.
In other words, rTail server always is listening in the port UDP to receive events and logs. 

__4) Sending logs to rTail server__

I have created a bash script to send all log events to the rTail server. The above rTail Puppet module also enables it to start automatically  to send logs to rTail server when booting the VM. 

You can find the bash script under `/etc/init.d/rtailsendlogs` and can run it whenever, as shown below:

```
$ sudo service rtailsendlogs status
[wso2am02a] is sending logs to rTail.
[wso2esb01a] is sending logs to rTail.
[wso2esb02a] is sending logs to rTail.
[wso2dss01a] is sending logs to rTail.
[wso2greg01a] is sending logs to rTail.
[wiremock] is sending logs to rTail.

$ sudo service rtailsendlogs stop
[wso2am02a] is stopping sending logs to rTail ... success
[wso2esb01a] is stopping sending logs to rTail ... success
[wso2esb02a] is stopping sending logs to rTail ... success
[wso2dss01a] is stopping sending logs to rTail ... success
[wso2greg01a] is stopping sending logs to rTail ... success
[wiremock] is stopping sending logs to rTail ... success

$ sudo service rtailsendlogs start
[wso2am02a] is starting sending logs to rTail ... success
[wso2esb01a] is starting sending logs to rTail ... success
[wso2esb02a] is starting sending logs to rTail ... success
[wso2dss01a] is starting sending logs to rTail ... success
[wso2greg01a] is starting sending logs to rTail ... success
[wiremock] is starting sending logs to rTail ... success
```

__5) Visualizing all logs from Browser using rTail__

Just open this URL `http://localhost:8181` in your Browser (Host) and you should view the next:

<img src="https://github.com/Chilcano/box-vagrant-wso2-dev-srv/blob/master/_downloads/chilcano-box-vagrant-wso2-dev-srv-rtail-logs.png" width="300" alt="rTail to collect and visualize all WSO2 logs from a Browser"/>


## Monitoring the Infraestructure

_Soon I will use one of them: Riemann, Jolokia, CollectD/Graphite, Grafana, etc...._


## Deploying WSO2 C-App (car file) from Maven

Here an useful document explaining how to deploy/undeploy WSO2 C-Apps (car files) from Maven using `maven-car-deploy-plugin`: 
https://docs.wso2.com/display/DVS371/Deploying+and+Debugging#DeployingandDebugging-DeployingaC-ApptomultipleserversusingtheMavenplug-in

Well, I have created a WSO2 Multi-maven project ready to be deployed from Maven in WSO2 ESB-front and WSO2 ESB-back.
This simple WSO2 project implements an `Echo API` and includes a set of Pass Through Proxies, APIs, Enfpoints and Sequence Templates. In the next days this Project will be improved, now let me explain how to build and deploy it properly using Maven.

__1) Configure Maven properly__
If you want deploy the car file to Maven repsitory, then you will need to configure your `.m2/conf/settings.xml` with the correct repositories. In my case, I am using Apache Archiva 2.2.0 (http://archiva.apache.org) and this is my `settings.xml`:

```
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" 
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

<!-- localRepository
   | The path to the local repository maven will use to store artifacts.
   |
   | Default: ${user.home}/.m2/repository
  <localRepository>/Users/Chilcano/2maven-repo</localRepository>
  -->

  <pluginGroups>
  </pluginGroups>

  <proxies>
  </proxies>

  <servers>
    <!-- User created from Archiva web console -->
    <server>
      <id>my.internal</id>
      <username>chilcano</username>
      <password>chilcano1</password>
    </server>   
    <server>
      <id>my.snapshots</id>
      <username>chilcano</username>
      <password>chilcano1</password>
    </server>
  </servers>

  <mirrors>
    <!-- This config will create a mirror of 'central' repo -->
    <mirror>
      <id>my.internal</id>
      <url>http://localhost:8080/repository/internal/</url>
      <mirrorOf>central</mirrorOf>
    </mirror>
    <mirror>
      <id>my.snapshots</id>
      <url>http://localhost:8080/repository/snapshots/</url>
      <mirrorOf>snapshots</mirrorOf>
    </mirror>
  </mirrors>
 
  <profiles>
    <!-- Two repositories added (internal releases and snapshots) -->
    <profile>
      <id>default</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <repositories>
        <repository>
          <id>internal</id>
          <url>http://localhost:8080/repository/internal/</url>
          <releases>
            <enabled>true</enabled>
          </releases>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
        </repository>
        <repository>
          <id>snapshots</id>
          <url>http://localhost:8080/repository/snapshots/</url>
          <releases>
            <enabled>false</enabled>
          </releases>
          <snapshots>
            <enabled>true</enabled>
          </snapshots>
        </repository>
      </repositories>
    </profile>
  </profiles>

</settings>
```

__2) Configure your Parent POM file of your C-App Project__

In this case, our pom.xml is located under `~/1github-repo/box-vagrant-wso2-dev-srv/_src/wso2-pattern01-echoapi/pattern01-parent-echoapi/` where `~/1github-repo/box-vagrant-wso2-dev-srv/` is the directory where this Vagrant Box repo was downloaded.

Basically, this pom.xml has been configured following the instructions of above URL (https://docs.wso2.com/display/DVS371/Deploying+and+Debugging#DeployingandDebugging-DeployingaC-ApptomultipleserversusingtheMavenplug-in).


__3) Using Maven to build, deploy and undeploy WSO2 C-App Project__


* Go to your Project directory:
  `$ cd  

* To _build_:
  `$ mvn clean install`

* To _deploy_ in both remote WSO2 ESB servers and Maven repository:
  `mvn clean deploy -Dmaven.car.deploy.skip=false -Dmaven.deploy.skip=false -Dmaven.wagon.http.ssl.insecure=true -Dmaven.car.deploy.operation=deploy`

* To _undeploy_ in both remote WSO2 ESB servers and Maven repository:
  `mvn clean deploy -Dmaven.car.deploy.skip=false -Dmaven.deploy.skip=false -Dmaven.wagon.http.ssl.insecure=true -Dmaven.car.deploy.operation=deploy`

If '-Dmaven.deploy.skip=false' is used, then use this '-Dmaven.wagon.http.ssl.insecure=true', because It avoids the below error when deploying or undeploying.

```
[INFO] --- maven-car-deploy-plugin:1.1.0:deploy-car (default-deploy-car) @ pattern01-echoapi ---
[INFO] Deploying to Server...
[INFO] TSPath=/Users/Chilcano/1github-repo/box-vagrant-wso2-dev-srv/_mnt_wso2esb01a/repository/resources/security/wso2carbon.jks
[INFO] TSPWD=wso2carbon
[INFO] TSType=JKS
[INFO] Server URL=https://localhost:9449
[INFO] UserName=admin
[INFO] Password=admin
[INFO] Operation=undeploy
log4j:WARN No appenders could be found for logger (org.apache.axis2.description.AxisOperation).
log4j:WARN Please initialize the log4j system properly.
[ERROR] Deleting pattern01-echoapi_1.0.0.car to https://localhost:9449 Failed.
org.apache.axis2.AxisFault: Connection has been shutdown: javax.net.ssl.SSLHandshakeException: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
	at org.apache.axis2.AxisFault.makeFault(AxisFault.java:430)
	at org.apache.axis2.transport.http.SOAPMessageFormatter.writeTo(SOAPMessageFormatter.java:78)
	at org.apache.axis2.transport.http.AxisRequestEntity.writeRequest(AxisRequestEntity.java:84)
...
	at org.codehaus.plexus.classworlds.launcher.Launcher.launch(Launcher.java:229)
	at org.codehaus.plexus.classworlds.launcher.Launcher.mainWithExitCode(Launcher.java:415)
	at org.codehaus.plexus.classworlds.launcher.Launcher.main(Launcher.java:356)
Caused by: com.ctc.wstx.exc.WstxIOException: Connection has been shutdown: javax.net.ssl.SSLHandshakeException: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
```

__4) Check if the WSO2 C-App was deployed__

Just check the WSO2 logs or verify from Carbon Web Admin Console if all artifact were deployed.


## Updates

- 2015.11.13: Added the rTail puppet module 
- 2015.11.20: 
  * Added Wiremock samples (echo mock services) and WSO2 ESB multi-maven project.
  * Added `_downloads/vagrant-vboxguestadditions-workaroud.md`.
  * Added functionality to automount WSO2 folders of Guest to Host.
  * Improved README.md with information how to work with rTail.


## TODO

- Load balancing and Virtual Hosts/IPs (HA Proxy or nginx)
- Custom HealthCheck
- Correlation propagation between WSO2 servers and Backend 
- Custom Mediators (Authentication, Authorization, Logging, Correlation, Common Validations and Transformations)
- WSO2 services patterns deployed as samples
- Docker


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
