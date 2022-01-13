#!/bin/bash
#启动mysql
service mysql restart
cd /var/www/ctf
unzip /var/www/ctf/src.zip
rm -rf /var/www/ctf/src.zip
chmod 666 /var/www/ctf/*.php
chmod 666 /var/www/ctf/*.html
chmod 666 /var/www/ctf/static/images/*
chmod 666 /var/www/ctf/static/images/wall_page/*
chmod 666 /var/www/ctf/static/js/*
chmod 666 /var/www/ctf/static/js/lib/*
chmod 666 /var/www/ctf/static/style/*
chmod 666 /var/www/ctf/static/style/font-awesome/*
chmod 666 /var/www/ctf/js/*
chmod 666 /var/www/ctf/js/layer/skin/default/*
chmod 666 /var/www/ctf/css/*
chmod +rx /var/www/ctf/css
chmod +rx /var/www/ctf/img
chmod +rx /var/www/ctf/js
chmod +rx /var/www/ctf/js/layer
chmod +rx /var/www/ctf/js/layer/skin/
chmod +rx /var/www/ctf/js/layer/skin/default
chmod +rx /var/www/ctf/static/
chmod +rx /var/www/ctf/static/images
chmod +rx /var/www/ctf/static/images/wall_page
chmod +rx /var/www/ctf/static/js
chmod +rx /var/www/ctf/static/js/lib
chmod +rx /var/www/ctf/static/style/font-awesome
chmod +rx /var/www/ctf/static/style

#给文件加权限
chown mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql

#修改密码
mysqladmin -u root password "root"
mysql -uroot -proot -e "create database ctf;"
mysql -uroot -proot ctf < /var/www/ctf/ctf.sql
rm -rf /var/www/ctf/ctf.sql
#重启apache2
service apache2 restart

#永不退出的进程
tail -f /var/log/1.txt
