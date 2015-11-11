#!/bin/sh

# Directory in guest VM where the WSO2 files will be downloaded
# '/vagrant' is a folder to share between Host and Guest
mkdir -p /vagrant/_downloads
cd /vagrant/_downloads

# Postgres Driver
FILE=postgresql-9.4-1201.jdbc41.jar

if [ -f $FILE ];
then
   echo "'"$FILE"' JDBC driver already downloaded."
else
   wget https://jdbc.postgresql.org/download/postgresql-9.4-1201.jdbc41.jar
fi

# ESB 4.8.1
FILE=wso2esb-4.8.1.zip

if [ -f $FILE ];
then
   echo "'"$FILE"' already downloaded."
else
   wget --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" http://dist.wso2.org/products/enterprise-service-bus/4.8.1/wso2esb-4.8.1.zip
fi

# AM 1.8.0
FILE=wso2am-1.8.0.zip

if [ -f $FILE ];
then
   echo "'"$FILE"' already downloaded."
else
   wget --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" http://product-dist.wso2.com/products/api-manager/1.8.0/wso2am-1.8.0.zip
fi

# GREG 5.1.0
FILE=wso2greg-5.1.0.zip

if [ -f $FILE ];
then
   echo "'"$FILE"' already downloaded."
else
   wget --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" http://product-dist.wso2.com/products/governance-registry/5.1.0/wso2greg-5.1.0.zip
fi

## DSS 3.5.0
FILE=wso2dss-3.5.0.zip

if [ -f $FILE ];
then
   echo "'"$FILE"' already downloaded."
else
   wget --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" http://product-dist.wso2.com/products/data-services-server/3.5.0/wso2dss-3.5.0.zip
fi

## WIREMOCK 1.57
VERSION=1.57
FILE=wiremock-$VERSION-standalone.jar

if [ -f $FILE ];
then
   echo "'"$FILE"' already downloaded."
else
   wget http://repo1.maven.org/maven2/com/github/tomakehurst/wiremock/$VERSION/$FILE
fi

