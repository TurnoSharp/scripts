
#!/bin/bash

# Возвращение вывода к стандартному форматированию
NORMAL='\033[0m' # ${NORMAL}

# Цветом текста (жирным) (bold)
WHITE='\033[1;37m' #${WHITE}

#Цвет фона
BGRED='\033[41m'
BGGREEN='\033[42m'
BGBLUE='\033[44m'

tg="~/.scripts/telegram.sh"
#получаем статус web сервера
nginxstatus=$(systemctl status nginx | grep -Eo "running|dead|failed")

if [[ $nginxstatus = 'running' ]]
then
	$tg "nginx работает" > /dev/null
else
	$tg "nginx не работает" > /dev/null
	systemctl restart nginx
	sleep 1
	$tg "Статус nginx после перезапуска $(systemctl status nginx | grep -Eo "running|dead|failed")!!" > /dev/null
fi

phpfpmstatus=$(systemctl status php7.2-fpm | grep -Eo "running|dead|failed")

if [[ $phpfpmstatus = 'running' ]]
then
	$tg "PHP-FPM запущен" > /dev/null
else
	$tg "PHP-FPM не работает" /dev/null
	systemctl restart php7.2-fpm
	sleep 1
	$tg "Статус php-fpm после перезапуска $(systemctl status php7.2-fpm | grep -Eo "running|dead|failed")!!" > /dev/null
fi
