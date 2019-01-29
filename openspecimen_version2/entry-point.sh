#!/bin/bash


echo "Replacing database values."

sed -i "s/<db_username>/$db_username/g" /usr/local/tomcat/conf/context.xml
sed -i "s/<db_password>/$db_password/g" /usr/local/tomcat/conf/context.xml
sed -i "s/<database_host>/$db_host/g" /usr/local/tomcat/conf/context.xml
sed -i "s/<driver_class>/$driver_class/g" /usr/local/tomcat/conf/context.xml
sed -i "s/<database_port>/$db_port/g" /usr/local/tomcat/conf/context.xml
sed -i "s/<database_name>/$db_name/g" /usr/local/tomcat/conf/context.xml


rm -r /usr/local/tomcat/webapps/ROOT 
rm -r /usr/local/tomcat/webapps/docs 
rm -r /usr/local/tomcat/webapps/examples 
ls /usr/local/tomcat/webapps
mkdir -p /usr/local/openspecimen/os-data 
mkdir -p /usr/local/openspecimen/os-plugins
/usr/local/tomcat/bin/catalina.sh start
sleep 15
tail -f /usr/local/tomcat/logs/catalina.out -f /usr/local/openspecimen/os-data/logs/os.log
