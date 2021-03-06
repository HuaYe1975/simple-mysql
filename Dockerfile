FROM centos:7

MAINTAINER Romeo Hua <romeohua@hotmail.com>

EXPOSE 3306/tcp

VOLUME /var/lib/mysql
VOLUME /var/log/mysql

#RUN groupadd -r mysql && useradd -r -g mysql mysql

# -----------------------------------------------------------------------------
# Install MySQL
# -----------------------------------------------------------------------------
RUN yum -y update \
	&& yum -y localinstall http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm --nogpgcheck \
	&& yum --setopt=tsflags=nodocs -y install mysql-community-server \
	&& yum -y install psmisc \
	; rm -rf /var/cache/yum/* \
	; yum clean all

ENV MYSQL_MAJOR 5.6
ENV MYSQL_VERSION 5.6.30

ENV MYSQL_ROOT_PASSWORD "romeohua"
ENV MYSQL_USER "romeohua"
ENV MYSQL_USER_PASSWORD "romeohua"
ENV MYSQL_USER_DATABASE "test"


ADD my.cnf /etc/my.cnf 
ADD boot.sh /usr/local/bin/boot.sh
RUN chmod +x /usr/local/bin/boot.sh

CMD ["/usr/local/bin/boot.sh", "-D", "FOREGROUND"]