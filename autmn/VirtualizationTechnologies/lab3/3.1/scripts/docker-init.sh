#!/bin/bash

CYAN="\e[96m"
YELLOW="\e[33m"
RED="\e[31m"
BG_PURPLE="\e[45m"
BG_YELOW="\e[43m"
BG_GRAY="\e[100m"
ENDCOLOR="\e[0m"

DOCKERHUB_USERNAME="xoeqvp"

BASEDIR="/home/glados/Desktop/University/University/ITMO_4/autmn/VirtualizationTechnologies/lab4"

echo -e "${BG_PURPLE}Проверяю, установлен ли докер${ENDCOLOR}"
echo -e "${BG_GRAY}docker --version${ENDCOLOR}"

docker --version

if [ $? -ne 0 ]; then
	echo -e "${RED}Docker не найден... или еще чего, я отказываюсь работать :P${ENDCOLOR}"
	exit 0
else
        echo -e "${CYAN}Docker установлен. Ну или ты меня хорошо обманываешь Т_Т${ENDCOLOR}"
fi

echo -e "${BG_PURPLE}Запускаю hello-контейнер${ENDCOLOR}"
echo -e "${BG_GRAY}docker run --name hello_delete_me hello-world${ENDCOLOR}"
docker run --name hello_delete_me hello-world
echo -e "${BG_PURPLE}Список контейнеров${ENDCOLOR}"
echo -e "${BG_GRAY}docker container ls --all${ENDCOLOR}"
docker container ls --all

echo -e "${BG_YELOW}Не знаю какой смысл запускать что бы то ни было из второго пункта лр - но вот${ENDCOLOR}"
echo -e "${BG_GRAY}docker run Hello_Rumskiy${ENDCOLOR}"
docker run Hello_Rumskiy

echo -e "${BG_YELOW}Перейти к запуску Apache(y/n)? ${ENDCOLOR}"

read yn

case $yn in 
	y ) source $BASEDIR/scripts/init-nginx.sh;;
	n ) echo Ну и не надо Т_Т, пойду / снесу;
		exit;;
	* ) echo Что то не то ты ввел, я закругляюсь :Р;
		exit 1;;
esac








