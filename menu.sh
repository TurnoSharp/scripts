
#!/bin/bash

green='\e[32m]'
blue='\e[34m]'
bgblue='\033[44m'
white='\033[1;37m'
clear='\e[0m'

ColorGreen(){
	echo -ne $green$1$clear
}

ColorBlue(){
	echo -ne $blue$1$clear
}

BackgroundBlue(){
	echo -ne $bgblue$white$1$clear
}

open_ports(){
	BackgroundBlue '====== Список открытых портов ss -lupnt ========= \n'
	echo ""
	ss -lupnt
	echo ""
	BackgroundBlue '------------------------------------------------- \n'
}

load_average(){
	line=$(uptime)
	BackgroundBlue '============ LOAD AVERAGE ============= \n'
	echo ${line#*users,}
	BackgroundBlue '--------------------------------------- \n'
}

mem_free(){
	BackgroundBlue '======= Статус оперативной памяти ===== \n'
	echo ""
	free -h
	echo ""
	BackgroundBlue '--------------------------------------- \n'
}

kernel_os_version(){
	BackgroundBlue '======= Информация о версии ядра и ОС ========= \n'
	echo ""
	echo $(cat /etc/os-release | grep PRETTY_NAME | awk -F"=" '{ print $2}')
	uname -r
	echo ""
	BackgroundBlue '----------------------------------------------- \n'
}

all_check(){
	kernel_os_version
	load_average
	mem_free
	open_ports
}
server_name=$(hostname)

server_ip=$(wget -O - -q icanhazip.com)

menu(){
echo -ne "
$(BackgroundBlue ' Сервер ')
$(BackgroundBlue "$server_ip $server_name")
$(ColorGreen '1)') Открытые порты
$(ColorGreen '2)') Нагрузка на сервер
$(ColorGreen '3)') ОЗУ
$(ColorGreen '4)') Версия ядра
$(ColorGreen '5)') Check All
$(ColorGreen '0)') Выход
"

read a
	case $a in
		1) open_ports; menu;;
		2) load_average; menu;;
		3) mem_free; menu;;
		4) kernel_os_version; menu;;
		5) all_check; menu;;
		0) exit 0;;
		*) "Неверная опция"; WrongCommand;;
	esac
}

menu




