# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

custom_props = File.expand_path("../vagrant_custom_properties", __FILE__)
load custom_props

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = $base_box
  config.vm.box_url = $base_box_url
  config.vm.network :private_network, ip: $ip
  config.vm.hostname = $host + ".local"

  # Mount/Sync extra folder '_mnt_opt' in host with '/opt' in guest
  # suitable to deploy *.car or other artifacts to servers or checking log files
  config.ssh.sudo_command = "sudo %c"
  config.vm.synced_folder "_mnt_wso2am02a/", "/opt/wso2am02a", create: true
  config.vm.synced_folder "_mnt_wso2esb01a/", "/opt/wso2esb01a", create: true
  config.vm.synced_folder "_mnt_wso2esb02a/", "/opt/wso2esb02a", create: true
  config.vm.synced_folder "_mnt_wso2dss01a/", "/opt/wso2dss01a", create: true
  config.vm.synced_folder "_mnt_wiremock/", "/opt/wiremock", create: true

  # ==================================== #
  # WSO2 STACK FOR DEVELOPMENT (SERVERS) #
  # ==================================== #

  config.vm.define "wso2srv" do |wso2srv|
    # AM (offset +0)
    wso2srv.vm.network "forwarded_port", guest: 9443, host: 9443
    wso2srv.vm.network "forwarded_port", guest: 8280, host: 8280

    # ESB-01 (offset +6)
    wso2srv.vm.network "forwarded_port", guest: 9449, host: 9449
    wso2srv.vm.network "forwarded_port", guest: 8286, host: 8286

    # ESB-02 (offset +2)
    wso2srv.vm.network "forwarded_port", guest: 9445, host: 9445
    wso2srv.vm.network "forwarded_port", guest: 8282, host: 8282

    # DSS (offset +3)
    wso2srv.vm.network "forwarded_port", guest: 9446, host: 9446
    wso2srv.vm.network "forwarded_port", guest: 8283, host: 8283

    # GREG (offset +8)
    wso2srv.vm.network "forwarded_port", guest: 9451, host: 9451

    # WIREMOCK
    wso2srv.vm.network "forwarded_port", guest: 7788, host: 7788

    # RTAIL
    wso2srv.vm.network "forwarded_port", guest: 8181, host: 8181

    wso2srv.vm.provider "virtualbox" do |vb|
      # Enable operations from VirtualBox GUI
      #vb.gui = true

      vb.name = $host
      vb.customize ["modifyvm", :id, "--memory", "4096"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
      vb.customize ["modifyvm", :id, "--acpi", "on"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]

      ### Install JDK and Ubuntu tools
      wso2srv.vm.provision :shell, :path => "provision/wso2-stack-srv/shell/1_install_init.sh"

      ### Download WSO2 files an other dependencies into guest VM
      wso2srv.vm.provision :shell, :path => "provision/wso2-stack-srv/shell/2_download.sh"
      
      ### Add/increase Sawp partition, valid for 'ubuntu/trusty64'
      wso2srv.vm.provision :shell, :path => "provision/wso2-stack-srv/shell/3_add_swap.sh"

      wso2srv.vm.provision "puppet" do |puppet|
        puppet.manifests_path = "provision/wso2-stack-srv/puppet/manifests"
        puppet.manifest_file  = "site.pp"
        puppet.module_path = "provision/wso2-stack-srv/puppet/modules"
      end
    end

  end

end
