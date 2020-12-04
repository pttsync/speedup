#!/bin/sh

CURL_GROUP_CACHE="/tmp/clash_gorup.json"
CURL_NOW_CACHE="/tmp/clash_now.json"
CURL_CACHE="/tmp/clash_curl.json"
HISTORY_PATH="/etc/clash/history"
SECRET=""
LAN_IP="10.1.1.1"
PORT="9090"

curl -m 5 --retry 2 -w %{http_code}"\n" -H "Authorization: Bearer ${SECRET}" -H "Content-Type:application/json" -X GET http://"$LAN_IP":"$PORT"/proxies > "$CURL_CACHE" 2>/dev/null
if [ "$(sed -n '$p' "$CURL_CACHE" 2>/dev/null)" = "200" ]; then
	cat "$CURL_CACHE" |jsonfilter -e '@["proxies"][@.type="Selector"]["name"]' > "$CURL_GROUP_CACHE" 2>/dev/null
	cat "$CURL_CACHE" |jsonfilter -e '@["proxies"][@.type="Selector"]["now"]' > "$CURL_NOW_CACHE" 2>/dev/null
    awk 'NR==FNR{a[i]=$0;i++}NR>FNR{print a[j]"#*#"$0;j++}' "$CURL_GROUP_CACHE" "$CURL_NOW_CACHE" > "$HISTORY_PATH" 2>/dev/null
fi
rm -rf /tmp/clash_*.json  2>/dev/null 
