#!/bin/bash

ensureProperties() {
  if [ -z "$DB_USERNAME" ]; then
    echo "Error: database user not specified. Please specify the value for DB_USERNAME in env.list file.";
    exit 1;
  fi

  if [ -z "$DB_PASSWORD" ]; then
    echo "Error: database password not specified. Please specify the value for DB_PASSWORD in env.list";
    exit 1;
  fi

  if [ -z "$DB_HOST" ]; then
    echo "Error: db_host not specified. Please specify the value for DB_HOST in env.list";
    exit 1;
  fi

  if [ -z "$DRIVER_CLASS" ]; then
    echo "Error: driver class not specified. Please specify the value for DRIVER_CLASS in env.list";
    exit 1;
  fi

  if [ -z "$DB_PORT" ]; then
    echo "Error: database port not specified. Please specify the value for DB_PORT in env.list";
    exit 1;
  fi

  if [ -z "$DB_NAME" ]; then
    echo "Error: database name not specified. Please specify the value for DB_NAME in env.list";
    exit 1;
  fi
}

configureContextFile() {
  echo "Replacing database values."
  sed -i "s/<db_username>/$DB_USERNAME/g"   /usr/local/tomcat/conf/context.xml
  sed -i "s/<db_password>/$DB_PASSWORD/g"   /usr/local/tomcat/conf/context.xml
  sed -i "s/<database_host>/$DB_HOST/g"     /usr/local/tomcat/conf/context.xml
  sed -i "s/<driver_class>/$DRIVER_CLASS/g" /usr/local/tomcat/conf/context.xml
  sed -i "s/<database_port>/$DB_PORT/g"     /usr/local/tomcat/conf/context.xml
  sed -i "s/<database_name>/$DB_NAME/g"     /usr/local/tomcat/conf/context.xml
}

removeUnwantedDir() {
  echo "Removing the unessasary files from webapps directory."
  rm -r /usr/local/tomcat/webapps/ROOT
  rm -r /usr/local/tomcat/webapps/docs
  rm -r /usr/local/tomcat/webapps/examples
  rm -r /usr/local/tomcat/host-manager
  rm -r /usr/local/tomcat/manager
}

startTomcat() {
  echo "Creating data and plugin directory for OpenSpecimen"
  mkdir -p /usr/local/openspecimen/os-data
  mkdir -p /usr/local/openspecimen/os-plugins

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
  startTomcat;
}

main;
