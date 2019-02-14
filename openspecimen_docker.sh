#!/bin/bash

input=$1
imageVersion=$2

if [ -z "$input" ]; then
  echo "Please run the command ./openspecimen_docker.sh --help";
  exit 1;
fi

createTemplate() {
  if [ -f "config.properties" ]; then
    echo "File is already present in the current directory."
    return;
  fi

  echo "Creating a config.properties file template."
  echo "Enter the all property values in the config.properties file."
  echo "Run the script as ./openspecimen_docker.sh config.properties <OpenSpecimen_version> "
  echo "db_host=" >> config.properties
  echo "db_port=" >> config.properties 
  echo "db_user=" >> config.properties
  echo "db_passwd=" >> config.properties
  echo "db_type=" >> config.properties 
  echo "host_data_dir=" >> config.properties
  echo "host_port=" >> config.properties
}

checkProperties() {
  host_data_dir=$(cat config.properties | grep "^host_data_dir=" | cut -d'=' -f2 | sed 's/ //g');
  
  if [ -z "$host_data_dir" ]; then
    echo "Error: host_data_dir not specified. Please specify the value for host_data_dir in config.properties file";
    exit 1;
  fi
  
  if [ -z "$imageVersion" ]; then
    echo "OpenSpecimen image version is not specified.";
    echo "Run the script as ./openspecimen_docker.sh config.properties <OpneSpecimen_Image_Version>";
    exit 1;
  fi

  docker run --name=openspecimen --env-file=config.properties -v $host_data_dir:/usr/local/openspecimen/os-data -v /etc/localtime:/etc/localtime -v /etc/timezone:/etc/timezone -p $host_port:8080 $imageVersion
}

main() {
  while :
  do
  case $input in
    --create-config-template)
	createTemplate;
        break
        ;;
    --help)
      echo "Run the ./openspecimen_docker.sh --create-config-template command to generate file."
      break
      ;;
    config.properties)
      if [ -f "config.properties" ]
      then
        checkProperties;
      else
	echo "config.properties file is not present in current directory.";
      fi
      break
      ;;
    *)
      echo "Invalid option entered."
      echo "Please run the ./openspecimen_docker.sh --help command for help."
      exit
      ;;
  esac
  done
}

main;
