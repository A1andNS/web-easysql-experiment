FROM ubuntu:18.04

MAINTAINER A1andNS "lilongxinalan@live.com"

ENV REFRESHED_AT 2022-01-13

ENV LANG C.UTF-8

#更新源
RUN rm /etc/apt/sources.list
COPY sources.list /etc/apt/sources.list

RUN apt-get update

#防止Apache安装过程中地区设置出错
ENV DEBIAN_FRONTEND noninteractive

#安装apache2
RUN apt-get install apache2 -y

#安装zip
RUN apt-get install zip -y

#安装php
RUN apt-get install php7.4 -y
RUN apt-get install libapache2-mod-php -y --fix-missing
RUN apt-get install php7.4-mysql -y

#安装mysql
RUN apt-get install mysql-server -y
RUN apt-get install mysql-client -y

#配置apache更改根目录
RUN mkdir /var/www/ctf
RUN sed -i 's#/var/www/html#/var/www/ctf#g' /etc/apache2/sites-available/default-ssl.conf
RUN sed -i 's#/var/www/html#/var/www/ctf#g' /etc/apache2/sites-enabled/000-default.conf
RUN echo "ServerName localhost:80" >> /etc/apache2/apache2.conf

#修改mysql文件读写
RUN echo "secure_file_priv=''" >> /etc/mysql/mysql.conf.d/mysqld.cnf
RUN service apparmor teardown
RUN chown -R mysql:mysql /var/www/ctf
RUN chmod 777 /var/www/ctf

#导入题目源码
COPY src.zip /var/www/ctf/src.zip
COPY ctf.sql /var/www/ctf/ctf.sql

#添加永久进程
RUN touch /var/log/1.txt
RUN chmod +x /var/log/1.txt

#启动脚本
COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh
ENTRYPOINT cd /root;./start.sh

#暴露端口
EXPOSE 80