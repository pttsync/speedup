#!/bin/sh

sed -i 's_downloads.openwrt.org_mirrors.tuna.tsinghua.edu.cn/openwrt_' /etc/opkg/distfeeds.conf

opkg update
opkg install wget curl unzip
opkg install ipset iptables-mod-tproxy luci-app-smartdns

wget "https://ghproxy.kne.pm/https://github.com/imKnect/speedup/archive/refs/heads/master.zip" -O speedup-master.zip
unzip speedup-master.zip
cp -r speedup-master/etc/* /etc/
wget "https://cdn.jsdelivr.net/gh/Hackl0us/GeoIP2-CN@release/Country.mmdb" -O /etc/clash/Country.mmdb
chmod a+x /etc/init.d/clash

clashp_url=`curl -s "https://api.github.com/repos/Dreamacro/clash/releases/tags/premium" | grep "url.*linux-amd64.*gz" | sed 's/.*\(http.*gz\)\"/\1/g'`
clashp_version=`echo $clashp_url | sed 's/.*premium\/\(.*\).gz/\1/g'`
better_clashp_url="https://ghproxy.kne.pm/"$clashp_url
wget $better_clashp_url
gzip -dk $clashp_version.gz
mv $clashp_version /etc/clash/clash
chmod a+x /etc/clash/clash
