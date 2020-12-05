#!/bin/sh

SUB_LIST="/etc/clash/sub.link"
CONFIG_FILE="/etc/clash/config.yaml"

echo "Cheking file sub.list..."
if [ -f $SUB_LIST ]; then
	url=$(sed -n 1p $SUB_LIST)
	echo "Getting clash config from $url..."
	wget --no-check-certificate --user-agent="wget/OpenWrt" $url -O /tmp/config.yaml >/dev/null 2>&1
	if [[ "$?" -eq "0" ]]; then
		cmp /tmp/config.yaml $CONFIG_FILE -s
		if [[ "$?" -eq "1" ]]; then
			echo "Covering old config..."
			mv /tmp/config.yaml $CONFIG_FILE
			echo "Restarting clash service..."
			/etc/init.d/clash restart
		else
			echo "Config file is up to date! Nothing changed."
			rm -f /tmp/config.yaml
		fi
	else
		echo "Download ERROR! Nothing changed."
	fi
else
	echo "No such file!"
fi