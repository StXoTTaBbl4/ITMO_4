#!/bin/bash

set -e

CYAN="\e[96m"
YELLOW="\e[33m"
RED="\e[31m"
BG_PURPLE="\e[45m"
BG_YELOW="\e[43m"
BG_GRAY="\e[100m"
ENDCOLOR="\e[0m"

BASEDIR="/home/glados/Desktop/University/University/ITMO_4/autmn/VirtualizationTechnologies/lab4"
MARIADB_HOME="${BASEDIR}/dockerfiles/mariadb"

cd $MARIADB_HOME

echo -e "${BG_PURPLE}Запуск контейнера с MariaDB${ENDCOLOR}"

echo "Содержимое докер-файла:"
cat Dockerfile

echo -e "${BG_PURPLE}Создаю изображение${ENDCOLOR}"
echo -e "${BG_GRAY}docker build -t xoeqvdp/lab3-mariadb .${ENDCOLOR}"
docker build -t xoeqvdp/lab3-mariadb .

echo -e "${BG_PURPLE}Создаю контейнер${ENDCOLOR}"
echo -e "${BG_GRAY}docker run -d -p 3306:3306 --name mariadb-app xoeqvdp/lab3-mariadb${ENDCOLOR}"
docker run -d -p 3306:3306 --name mariadb-app xoeqvdp/lab3-mariadb

echo -e "${BG_PURPLE}Для подключения к БД(пароль - rootpass):${ENDCOLOR}"
echo -e "${YELLOW}docker exec -it mariadb-app mariadb -u root -p${ENDCOLOR}"







