#!/bin/bash

CYAN="\e[96m"
YELLOW="\e[33m"
RED="\e[31m"
BG_RED="\e[101m"
BG_LIGHTCYAN="\e[45m"
BG_LIGHYELOW="\e[93m"
ENDCOLOR="\e[0m"

BASEDIR="/home/glados/Desktop/University/University/ITMO_4/autmn/VirtualizationTechnologies/lab4"
NGINX_HOME="${BASEDIR}/dockerfiles/nginx"
MARIADB_HOME="${BASEDIR}/dockerfiles/mariadb"
NEXTCLOUD_HOME="${BASEDIR}/dockerfiles/nextcloud"
PHPVB_HOME="${BASEDIR}/dockerfiles/phpvirtualbox"

echo -e "\n${BG_RED}=====Hello=====${ENDCOLOR}\n"

echo -e "${BG_LIGHTCYAN}Удаляю hello-контейнер${ENDCOLOR}\n"
docker rm hello_delete_me 

echo -e "\n${BG_RED}=====ngnix=====${ENDCOLOR}\n"

echo -e "${BG_LIGHTCYAN}Останавливаю и удаляю контейнер nginx${ENDCOLOR}\n"
docker container stop nginx-app
docker container rm nginx-app

echo -e "${BG_LIGHTCYAN}Удаляю image nginx2${ENDCOLOR}\n"
docker image rm xoeqvdp/lab3-nginx

echo -e "${BG_LIGHTCYAN}Удаляю файл страницы nginx2${ENDCOLOR}\n"
rm $NGINX_HOME/index.html

echo -e "\n${BG_RED}=====MariaDB=====${ENDCOLOR}\n"

echo -e "${BG_LIGHTCYAN}Останавливаю и удаляю контейнер MariaDB${ENDCOLOR}\n"
docker container stop mariadb-app
docker container rm mariadb-app

echo -e "${BG_LIGHTCYAN}Удаляю image mariadb${ENDCOLOR}\n"
docker image rm xoeqvdp/lab3-mariadb

echo -e "\n${BG_RED}=====NextCloud=====${ENDCOLOR}\n"
cd $NEXTCLOUD_HOME
docker compose down

echo -e "\n${BG_RED}=====phpVirtualBox=====${ENDCOLOR}\n"
cd $PHPVB_HOME
docker compose down

#clear

echo -e "${BG_LIGHTCYAN}Очистка завершена${ENDCOLOR}\n"
echo -e "${BG_LIGHTCYAN}Список контейнеров${ENDCOLOR}\n"
docker container ls -a

echo -e "${BG_LIGHTCYAN}Список изображений${ENDCOLOR}\n"
docker image ls


