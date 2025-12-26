CYAN="\e[96m"
YELLOW="\e[33m"
BG_PURPLE="\e[45m"
BG_YELLOW="\e[43m"
BG_GRAY="\e[100m"
ENDCOLOR="\e[0m"


echo -e "${BG_PURPLE}NC:Останавливаем контейнер${ENDCOLOR}"
sudo lxc exec NextCloud -- docker stop nc1
sudo lxc exec NextCloud -- docker rm nc1

echo -e "${BG_PURPLE}NC:Удаляем проброс${ENDCOLOR}"
sudo lxc config device remove NextCloud http8089

echo -e "${BG_PURPLE}Стопаем контейнеры${ENDCOLOR}"
for c in Apache NextCloud MC; do
  sudo lxc stop $c
  echo -e "\t${CYAN}$c остановлен${ENDCOLOR}"
done


echo -e "${CYAN}====FIN====${ENDCOLOR}"
