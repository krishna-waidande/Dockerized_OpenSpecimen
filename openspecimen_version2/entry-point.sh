#!/bin/bash


echo "Replacing database values."

sed -i "s/<db_username>/$db_username/g" /usr/local/tomcat/conf/context.xml
sed -i "s/<db_password>/$db_password/g" /usr/local/tomcat/conf/context.xml
sed -i "s/<database_host>/$db_host/g" /usr/local/tomcat/conf/context.xml
sed -i "s/<driver_class>/$driver_class/g" /usr/local/tomcat/conf/context.xml
sed -i "s/<database_port>/$db_port/g" /usr/local/tomcat/conf/context.xml
sed -i "s/<database_name>/$db_name/g" /usr/local/tomcat/conf/context.xml

#Removing the unessasary files from webapps directory.
rm -r /usr/local/tomcat/webapps/ROOT 
rm -r /usr/local/tomcat/webapps/docs 
rm -r /usr/local/tomcat/webapps/examples
rm -r /usr/local/tomcat/host-manager
rm -r /usr/local/tomcat/manager

#Creating data and plugin directory for OpenSpecimen.
mkdir -p /usr/local/openspecimen/os-data 
mkdir -p /usr/local/openspecimen/os-plugins

#Starting the Tomcat
/usr/local/tomcat/bin/catalina.sh start
sleep 15

#Displaying the Tomcat logs as well as OpenSpecimen logs.
tail -f /usr/local/tomcat/logs/catalina.out -f /usr/local/openspecimen/os-data/logs/os.log
