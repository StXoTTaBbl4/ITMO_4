#!/bin/bash

CYAN="\e[96m"
YELLOW="\e[33m"
RED="\e[31m"
BG_PURPLE="\e[45m"
BG_YELOW="\e[43m"
BG_GRAY="\e[100m"
ENDCOLOR="\e[0m"

BASEDIR="/home/glados/Desktop/University/University/ITMO_4/autmn/VirtualizationTechnologies/lab4"
NGINX_HOME="${BASEDIR}/dockerfiles/nginx"
NGINX_HTML_STRING="<html><body><h1>Hello from nginx! <br> Second name: Rumskiy</h1></body></html>"

set -e

echo -e "${BG_PURPLE}Подготавливаем к запуску контейнер с nginx${ENDCOLOR}"
echo -e "\t${CYAN}Создаю html файл${ENDCOLOR}"
echo $NGINX_HTML_STRING > $NGINX_HOME/index.html
echo -e "\tfile://${NGINX_HOME}/index.html"

echo -e "\t${CYAN}Собираю docker image для nginx2${ENDCOLOR}"

cd $NGINX_HOME
echo "Содержимое докер-файла:"
cat Dockerfile

echo -e "${BG_GRAY}docker build --no-cache -t xoeqvdp/lab3-nginx .${ENDCOLOR}"
docker build --no-cache -t xoeqvdp/lab3-nginx .

echo -e "\t${CYAN}Запускаю конейтнер в фоне${ENDCOLOR}"
echo -e "${BG_GRAY}docker run -d -p 8080:80 --name nginx-app xoeqvdp/lab3-nginx${ENDCOLOR}"
docker run -d -p 8080:80 --name nginx-app xoeqvdp/lab3-nginx

set +e

#echo -e "${BG_PURPLE}Список запущенных контейнеров${ENDCOLOR}"
#docker container ls
echo -e "${BG_PURPLE}Проверить доступность${ENDCOLOR}"
echo -e "\e]8;;http://localhost:8080\e\\Тыкай на меня, давай. ДАВАЙ ЖЕ.\e]8;;\e\\"

echo -e "${BG_YELOW}Перейти к запуску MariaDB(y/n)? ${ENDCOLOR}"

read yn

case $yn in 
	y ) source ./init-mariadb.sh;;
	n ) echo Ну и не надо Т_Т;
		exit;;
	* ) echo Что то не то ты ввел, я закругляюсь :Р;
		exit 1;;
esac
