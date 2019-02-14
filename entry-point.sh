#!/bin/bash

ensureProperties() {
  if [ -z "$db_user" ]; then
    echo "Error: database user not specified. Please specify the value for db_user in config.properties file.";
    exit 1;
  fi

  if [ -z "$db_passwd" ]; then
    echo "Error: database password not specified. Please specify the value for db_passwd in config.properties";
    exit 1;
  fi

  if [ -z "$db_host" ]; then
    echo "Error: db_host not specified. Please specify the value for db_host in config.properties";
    exit 1;
  fi

  if [ -z "$db_type" ]; then
    echo "Error: driver class not specified. Please specify the value for db_type in config.properties";
    exit 1;
  fi

  if [ -z "$db_port" ]; then
    echo "Error: database port not specified. Please specify the value for DB_PORT in config.properties";
    exit 1;
  fi

  if [ -z "$db_name" ]; then
    echo "Error: database name not specified. Please specify the value for DB_NAME in config.properties";
    exit 1;
  fi
}

configureContextFile() {
  echo "Replacing database values."
  sed -i "s/<db_username>/$db_user/g"   /usr/local/tomcat/conf/context.xml
  sed -i "s/<db_password>/$db_passwd/g" /usr/local/tomcat/conf/context.xml
  sed -i "s/<database_host>/$db_host/g" /usr/local/tomcat/conf/context.xml
  sed -i "s/<database_port>/$db_port/g" /usr/local/tomcat/conf/context.xml
  sed -i "s/<database_name>/$db_name/g" /usr/local/tomcat/conf/context.xml

  if [[ "$db_type" = "mysql" || "$db_type" = "MYSQL" ]]; then
    sed -i "s/<driver_class>/com.mysql.jdbc.Driver/g" /usr/local/tomcat/conf/context.xml
  fi
}

removeUnwantedDir() {
  echo "Removing the unessasary files from webapps directory."
  rm -r /usr/local/tomcat/webapps/ROOT
  rm -r /usr/local/tomcat/webapps/docs
  rm -r /usr/local/tomcat/webapps/examples
}

createDataAndPluginDir() {
  echo "Creating data and plugin directory for OpenSpecimen"
  mkdir -p /usr/local/openspecimen/os-data 
  mkdir -p /usr/local/openspecimen/os-plugins
}

startTomcat() {
  echo "Starting the Tomcat"
  /usr/local/tomcat/bin/catalina.sh start
  sleep 10

  echo "Displaying the Tomcat & OpenSpecimen logs"
  tail -f /usr/local/tomcat/logs/catalina.out -f /usr/local/openspecimen/os-data/logs/os.log
}

main() {
  ensureProperties;
  configureContextFile;
  removeUnwantedDir;
  createDataAndPluginDir;
  startTomcat;
}

main;
