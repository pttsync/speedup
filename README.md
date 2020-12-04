# speedup
Clash shell script for OpenWrt gateway transparent proxy  
and Clash != Clash Premium  
**do not issue** 

make sure there is a dir `/etc/clash`, and put clash core (rename it to `clash`), `config.yaml`, `Country.mmdb` in it.  

## /etc/init.d/clash  
main service file, make it executable by running `chmod +x /etc/init.d/clash` in shell.  
running `/etc/init.d/clash enable` to make startup with system.  
open it as text file and check it out for more info.  

## /etc/clash/script/backup.sh  
backup proxy selections in file `/etc/clash/history` for next run.  

## /etc/clash/script/restore.sh
restore last proxy selections saved in file `/etc/clash/history` for new run.   

---  

**you can change the path of these files, but you have to modify the code for sure**  

## thanks  
https://github.com/Mosney/Outlands  
https://github.com/frainzy1477/luci-app-clash  