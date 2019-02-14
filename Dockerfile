FROM tomcat:9-jre8

MAINTAINER krishnawaidande <krishna@krishagni.com>

#Adding first-class shell script to /opt dir.
ADD entry-point.sh /opt/

#Adding context.xml into Tomcat/conf dir.
ADD context.xml /usr/local/tomcat/conf/

#Adding Java heap size configuration file.
ADD setenv.sh /usr/local/tomcat/bin/

#Adding OpenSpecimen war file.
ADD openspecimen.war /usr/local/tomcat/webapps/openspecimen.war

#Adding properties file.
ADD openspecimen.properties /usr/local/tomcat/conf/openspecimen.properties

#Adding plugins jars.
ADD plugins/*.jar /usr/local/openspecimen/os-plugins/

#Adding database connector jars.
ADD db-connectors/*.jar /usr/local/tomcat/lib/

RUN chmod a+x /opt/*.sh
ENTRYPOINT ["/opt/entry-point.sh"]
