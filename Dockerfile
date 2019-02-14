FROM krishnawaidande/openspecimen:tomcat9

MAINTAINER krishnawaidande <krishna@krishagni.com>

#Adding first-class shell script to /opt dir.
ADD entry-point.sh /opt/

#Adding OpenSpecimen war file.
ADD openspecimen.war /usr/local/tomcat/webapps/openspecimen.war

#Adding plugins jars.
ADD plugins/*.jar /usr/local/openspecimen/os-plugins/

RUN chmod a+x /opt/*.sh

ENTRYPOINT ["/opt/entry-point.sh"]
