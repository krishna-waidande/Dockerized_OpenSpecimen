#!/bin/bash

input=$1
imageVersion=$2

if [ -z "$input" ]; then
  echo "Please run the command ./openspecimen_docker.sh --help";
  exit 1;
fi

printHelpMsg() {
  echo -e "\nUsage : ./openspecimen_docker.sh config.properties OpenSpecimen_Image_Version";
  echo "Script accepts the values from config.properties file & starts OpenSpecimen container.";
  echo -e "\nOptions:";
  echo -e  "--create-config-template \t This option generates template of config.properties file which is given as input to container. ";
  echo -e "\nBelow options are used in the script to start the container from image ";
  echo -e "--name \t \t Specify name of the container.";
  echo -e "-v \t \t Maps the host machine directory with the container directory.";
  echo -e "-p \t \t Maps the host machine port with the container port.";
  echo -e "--env-file \t Read in a file of environment variables";
  echo -e "-d \t \t Starts the container in detached mode.";
  echo -e "\nFor example :";
  echo -e "docker run -d --name=openspecimen --env-file=config.properties -v /home/user/data:/usr/local/openspecimen/os-data -v /etc/localtime:/etc/localtime -v /etc/timezone:/etc/timezone -p 8080:8080OpenSpecimen-v6.0"
}

createTemplate() {
  if [ -f "config.properties" ]; then
    echo "File is already present in the current directory."
    return;
  fi

  echo "Creating a config.properties file template."
  echo "Enter the all property values in the config.properties file."
  echo "Run the script as ./openspecimen_docker.sh config.properties <OpenSpecimen_version> "
  echo "#IP address of the host machine." >> config.properties
  echo "db_host=" >> config.properties
  echo -e "\n#Port no of database server.3306 for mysql, 1521 for oracle." >> config.properties
  echo "db_port=" >> config.properties 
  echo -e "\n#Database user under which OpenSpecimen will be install." >> config.properties
  echo "db_user=" >> config.properties
  echo -e "\n#Database on which OpenSpecimen will be install." >> config.properties
  echo "db_passwd=" >> config.properties
  echo -e "\n#Database type : mysql or oracle." >> config.properties
  echo "db_type=" >> config.properties 
  echo -e "\n#Host machine mapping data directory." >> config.properties
  echo "host_data_dir=" >> config.properties
  echo -e "\n#Host machine mapping port" >> config.properties
  echo "host_port=" >> config.properties
}

checkProperties() {
  host_data_dir=$(cat config.properties | grep "^host_data_dir=" | cut -d'=' -f2 | sed 's/ //g');
  host_port=$(cat config.properties | grep "^host_port=" | cut -d'=' -f2 | sed 's/ //g')

  if [ -z "$host_data_dir" ]; then
    echo "Error: host_data_dir not specified. Please specify the value for host_data_dir in config.properties file";
    exit 1;
  fi
  
  if [ -z "$imageVersion" ]; then
    echo "OpenSpecimen image version is not specified.";
    echo "Run the script as ./openspecimen_docker.sh config.properties <OpenSpecimen_image_version>";
    exit 1;
  fi

  if [ $host_port -le 1024 ]; then
    echo "Please specify the valid host_port no in the config.properties file."
    exit 1;
  fi

  docker run -d --name=openspecimen --env-file=config.properties -v $host_data_dir:/usr/local/openspecimen/os-data -v /etc/localtime:/etc/localtime -v /etc/timezone:/etc/timezone -p $host_port:8080 $imageVersion
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
      printHelpMsg;
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
