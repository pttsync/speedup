# speedup
Clash shell script for OpenWrt gateway transparent proxy  
and Clash != Clash Premium  
**do not issue** 

make sure there is a dir `/etc/clash`, and put clash core (rename it to `clash`), `config.yaml`, `Country.mmdb` in it.  

check dependency:
```shell
opkg update
opkg install ipset iptables-mod-tproxy
```

## /etc/init.d/clash  
main service file, make it executable by running `chmod +x /etc/init.d/clash` in shell.  
run `/etc/init.d/clash enable` to make it startup with system.  
```shell
/etc/init.d/clash start
/etc/init.d/clash restart/reload
/etc/init.d/clash stop
```
you can replace `/etc/init.d/clash` with `service`  
open it as text file and check it out for more info.  

## /etc/clash/subscribe.sh
get subscribe link from file `/etc/clash/sub.link` (one-line-url) then wget the config file, cover the old one, and restart service.  
the file is like (only one line, one link):  
```text
https://some.interesting.cloud/clash?token=give_Knect_some_money  
```

## /etc/clash/update_geoip.sh  
update `Country.mmdb` file and restart service.  

---  

**you can change the path of these files, but you have to modify the code for sure**  

## thanks  
https://github.com/Mosney/Outlands  
https://github.com/frainzy1477/luci-app-clash  
