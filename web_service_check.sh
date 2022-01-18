
#!/bin/bash

# Возвращение вывода к стандартному форматированию
NORMAL='\033[0m' # ${NORMAL}

# Цветом текста (жирным) (bold)
WHITE='\033[1;37m' #${WHITE}

#Цвет фона
BGRED='\033[41m'
BGGREEN='\033[42m'
BGBLUE='\033[44m'

#получаем статус web сервера
nginxstatus=$(systemctl status nginx | grep -Eo "running|dead|failed")

if [[ $nginxstatus = 'running' ]]
then
	echo -en "${WHITE} ${BGGREEN} Веб сервер работает ${NORMAL}\n"
else
	echo -en "${WHITE} ${BGRED} nginx не работает ${NORMAL}\n"
	systemctl restart nginx
	sleep 1
	echo -en "${WHITE} ${BGGREEN} Статус nginx после перезапуска $(systemctl status nginx | grep -Eo "running|dead|failed") ${NORMAL}\n"
	echo $(curl -I 192.168.1.64 | grep ОК) 
fi

phpfpmstatus=$(systemctl status php7.2-fpm | grep -Eo "running|dead|failed")

if [[ $phpfpmstatus = 'running' ]]
then
	echo -en "${WHITE} ${BGGREEN} PHP-FPM запущен ${NORMAL}\n"
else
	echo -en "${WHITE} ${BGRED} PHP-FPM не работает ${NORMAL}\n"
	echo -en "Инициализирую перезапуск..."
	systemctl restart php7.2-fpm
	sleep 1
	echo -en "${WHITE} ${BGGREEN} Статус php-fpm после перезапуска $(systemctl status php7.2-fpm | grep -Eo "running|dead|failed") ${NORMAL}\n"
fi
