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
NEXTCLOUD_HOME="${BASEDIR}/dockerfiles/nextcloud"

cd $NEXTCLOUD_HOME

echo -e "${BG_PURPLE}Запуск контейнера с NextCloud${ENDCOLOR}"

echo "Содержимое докер-файла:"
cat docker-compose.yaml

echo -e "${BG_PURPLE}Запускаю через docker-compose${ENDCOLOR}"
echo -e "${BG_GRAY}docker compose up -d${ENDCOLOR}"
docker compose up -d

echo -e "${BG_PURPLE}Проверить доступность${ENDCOLOR}"
echo -e "\e]8;;http://localhost:8088\e\\Тыкай на меня, давай. ДАВАЙ ЖЕ.\e]8;;\e\\"
