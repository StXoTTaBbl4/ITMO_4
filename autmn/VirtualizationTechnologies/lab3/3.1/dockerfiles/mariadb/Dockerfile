FROM mariadb:latest

ENV MYSQL_ROOT_PASSWORD=rootpass
ENV MYSQL_USER=labuser
ENV MYSQL_PASSWORD=userpass

WORKDIR /home/DB

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

