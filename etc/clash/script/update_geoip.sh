#!/bin/sh

URL="http://www.ideame.top/mmdb/Country.mmdb"
MMDB_FILE="/etc/clash/Country.mmdb"
# enhanced
# http://www.ideame.top/mmdb/Country.mmdb
# https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/Country.mmdb 

# origin
# https://geolite.clash.dev/Country.mmdb
# https://github.com/Dreamacro/maxmind-geoip/releases/latest/download/Country.mmdb

echo "Updating Country.mmdb..."
UPDATE=`wget -c4 --no-check-certificate --timeout=300 --user-agent="Mozilla" $URL -O /tmp/Country.mmdb`
if $UPDATE; then
	cmp -s /tmp/Country.mmdb $MMDB_FILE || { 
		echo "Covering old mmdb file..."
		mv /tmp/Country.mmdb $MMDB_FILE
		echo "Restarting clash service..."
		/etc/init.d/clash restart 
	} && { 
		echo "GEOIP is up to date! Nothing changed."
		rm -f /tmp/Country.mmdb 
	}
else
	echo "Download ERROR! Nothing changed."
fi
