#!/bin/sh

if [ -f /etc/clash/history ];then

HISTORY_PATH="/etc/clash/history"
SECRET=""
LAN_IP="10.1.1.1"
PORT="9090"
urlencode() {
    local data
    if [ "$#" != 1 ]; then
        return 1
    fi
    data=$(curl -s -o /dev/null -w %{url_effective} --get --data-urlencode "$1" "")
    if [ ! -z "$data" ]; then
        echo "${data##/?}"
    fi
    return 0
}
cat $HISTORY_PATH |while read line
do
    if [ -z "$(echo $line |grep "#*#")" ]; then
      continue
    else
      GORUP_NAME=$(urlencode "$(echo $line |awk -F '#*#' '{print $1}')")
      NOW_NAME=$(echo $line |awk -F '#*#' '{print $3}')
      curl -H "Authorization: Bearer ${SECRET}" -H "Content-Type:application/json" -X PUT -d '{"name":"'"$NOW_NAME"'"}' http://"$LAN_IP":"$PORT"/proxies/"$GORUP_NAME" >/dev/null 2>&1
    fi
done >/dev/null 2>&1 
fi 