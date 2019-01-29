FROM tomcat:9-jre8

MAINTAINER krishnawaidande <krishna@krishagni.com>

ADD entry-point.sh /opt/

ADD context.xml /usr/local/tomcat/conf/

ADD setenv.sh /usr/local/tomcat/bin/

ADD openspecimen.war /usr/local/tomcat/webapps/openspecimen.war

ADD openspecimen.properties /usr/local/tomcat/conf/openspecimen.properties

ADD plugins/*.jar /usr/local/openspecimen/os-plugins/

ADD db-connectors/*.jar /usr/local/tomcat/lib/

#ADD startup.sh /opt/

RUN chmod a+x /opt/*.sh
ENTRYPOINT ["/opt/entry-point.sh"]
