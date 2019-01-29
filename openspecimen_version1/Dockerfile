FROM tomcat:9-jre8

MAINTAINER krishnawaidande <krishna@krishagni.com>

ADD context.xml /usr/local/tomcat/conf/context.xml

ADD openspecimen.war /usr/local/tomcat/webapps/openspecimen.war

ADD openspecimen.properties /usr/local/tomcat/conf/openspecimen.properties

ADD plugins/*.jar /usr/local/openspecimen/os-plugins/

ADD mysql-connector-java-5.1.46-bin.jar /usr/local/tomcat/lib/mysql-connector-java-5.1.46-bin.jar

RUN apt-get update && rm -r /usr/local/tomcat/webapps/ROOT && rm -r /usr/local/tomcat/webapps/docs && rm -r /usr/local/tomcat/webapps/examples && mkdir -p /usr/local/openspecimen/os-data && mkdir -p /usr/local/openspecimen/os-plugins && /usr/local/tomcat/bin/catalina.sh start 
