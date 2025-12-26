#!/bin/bash

CYAN="\e[96m"
YELLOW="\e[33m"
BG_PURPLE="\e[45m"
BG_YELLOW="\e[43m"
BG_GRAY="\e[100m"
ENDCOLOR="\e[0m"

echo -e "${BG_YELLOW}ПОДРАЗУМЕВАЕТСЯ ЧТО ВСЕ КОНТЕЙНЕРЫ УЖЕ СОЗДАНЫ И НЕ ЗАПУЩЕНЫ${ENDCOLOR}"

echo -e "${BG_PURPLE}Список контейнеров:${ENDCOLOR}"
echo -e "${BG_GRAY}sudo lxc list${ENDCOLOR}"
sudo lxc list

echo -e "${BG_PURPLE}Выдача привелегий контейнеру NextCloud(ннада)${ENDCOLOR}"
echo -e "${BG_GRAY}sudo lxc config set NextCloud security.privileged true${ENDCOLOR}"
sudo lxc config set NextCloud security.privileged true
echo -e "${BG_GRAY}sudo lxc config set NextCloud raw.lxc "lxc.apparmor.profile=unconfined"${ENDCOLOR}"
sudo lxc config set NextCloud raw.lxc "lxc.apparmor.profile=unconfined"

echo -e "${BG_PURPLE}Запуск контейнеров${ENDCOLOR}"
echo -e "${BG_GRAY}sudo lxc start <...>${ENDCOLOR}"
for c in Apache NextCloud MC; do
  sudo lxc start $c
  echo -e "\t${CYAN}$c запущен${ENDCOLOR}"
done

echo -e "${BG_PURPLE}Установка ограничений по памяти${ENDCOLOR}"
echo -e "${BG_GRAY}sudo lxc config set <...> limits.memory 500MiB${ENDCOLOR}"
for c in Apache NextCloud MC; do
  sudo lxc config set $c limits.memory 500MiB
  echo -e "\t${CYAN}Ограничение применено: $c${ENDCOLOR}"
done

echo -e "${BG_PURPLE}Установка Apache2${ENDCOLOR}"
echo -e "${BG_GRAY}sudo lxc exec Apache -- apt update${ENDCOLOR}"
sudo lxc exec Apache -- apt update
echo -e "${BG_GRAY}sudo lxc exec Apache -- apt install apache2 -y${ENDCOLOR}"
sudo lxc exec Apache -- apt install apache2 -y

echo -e "${BG_PURPLE}Создание страницы для Apache2${ENDCOLOR}"
echo -e "${BG_GRAY}sudo lxc exec Apache -- bash -c 'echo "page_content" > /var/www/html/index.html'${ENDCOLOR}"
sudo lxc exec Apache -- bash -c 'echo "<h1>Rumskiy Aleksandr Maksimovich. Shob eti kodirovki leshiy pobral }:-| </h1>" > /var/www/html/index.html'
echo -e "${CYAN}====FIN====${ENDCOLOR}"


echo -e "${BG_PURPLE}Проброс портов для контейнера с NextCloud${ENDCOLOR}"
echo -e "${BG_GRAY}sudo lxc config device add NextCloud http8089 proxy listen=tcp:0.0.0.0:8089 connect=tcp:127.0.0.1:80${ENDCOLOR}"
sudo lxc config device add NextCloud http8089 proxy listen=tcp:0.0.0.0:8089 connect=tcp:127.0.0.1:80

echo -e "${BG_PURPLE}Установка NextCloud${ENDCOLOR}"

echo -e "${BG_GRAY}sudo lxc exec NextCloud -- apt install docker.io -y${ENDCOLOR}"
sudo lxc exec NextCloud -- apt install docker.io -y
echo -e "${BG_GRAY}sudo lxc exec NextCloud -- docker run --name nc1 -d -p 80:80 nextcloud${ENDCOLOR}"
sudo lxc exec NextCloud -- docker run --name nc1 -d -p 80:80 nextcloud

echo -e "${CYAN}====FIN====${ENDCOLOR}"

echo -e "${BG_PURPLE}Установка MidnightCommander${ENDCOLOR}"
echo -e "${BG_GRAY}sudo lxc exec MC -- apt update${ENDCOLOR}"
sudo lxc exec MC -- apt update
echo -e "${BG_GRAY}sudo lxc exec MC -- apt install mc -y${ENDCOLOR}"
sudo lxc exec MC -- apt install mc -y
echo -e "${CYAN}====FIN====${ENDCOLOR}"

echo -e "${BG_PURPLE}\nЕсли выше не было ошибок - есть шанс что все рабоатет${ENDCOLOR}"

echo -e "${BG_YELLOW}Проверить NextCloud${ENDCOLOR}"
echo -e "\e]8;;http://localhost:8089\e\\Тыкай на меня, давай. ДАВАЙ ЖЕ.\e]8;;\e\\"

echo -e "${BG_YELLOW}Проверить Apache: ищи ip в таблице ниже и открывай в браузере${ENDCOLOR}"
echo -e "\e]8;;http://10.138.209.104\e\\Ну или можешь попробовать ткнуть сюда\e]8;;\e\\"
sudo lxc list

echo -e "${BG_YELLOW}Проверить MidnightCommander: Выполни команду${ENDCOLOR}"
echo -e "${CYAN}sudo lxc exec MC -- mc${ENDCOLOR}"

echo -e "${BG_YELLOW}Веб интерфейс${ENDCOLOR}"
echo -e "${CYAN}https://localhost:8443${ENDCOLOR}"
echo -e "\e]8;;https://localhost:8443\e\\Ну или ткни сюда\e]8;;\e\\"



