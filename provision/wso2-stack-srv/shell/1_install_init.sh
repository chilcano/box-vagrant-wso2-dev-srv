#!/usr/bin/env bash

# Install JDK 7#!/bin/bash
apt-get update
apt-get -y upgrade
apt-get autoremove
apt-get -y install python-software-properties
add-apt-repository -y ppa:webupd8team/java
apt-get -q -y update

echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

apt-get -y install oracle-java7-installer

echo -e "\n\nJAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/environment;
export JAVA_HOME=/usr/lib/jvm/java-7-oracle/

# Install maven
apt-get -q -y install maven

# Install GIT and bash-completion
apt-get -q -y install git bash-completion
