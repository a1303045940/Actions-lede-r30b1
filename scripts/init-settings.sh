#!/bin/bash

#更改默认地址为192.168.8.1
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/luci2/bin/config_generate

# Add the default password for the 'root' user（Change the empty password to 'password'）
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' package/base-files/files/etc/shadow
#修改默认主题
#sed -i "s/luci-theme-design/luci-theme-$openWRT_THEME/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")
#修改默认IP地址
#sed -i "s/192\.168\.[0-9]*\.[0-9]*/$openWRT_IP/g" ./package/base-files/files/bin/config_generate
#修改默认主机名
sed -i "s/hostname='.*'/hostname='Openwrt'/g" ./package/base-files/files/bin/config_generate
#修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" ./package/base-files/files/bin/config_generate
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate

#修改默认WIFI名
sed -i "s/\.ssid=.*/\.ssid=Openwrt/g" $(find ./package/kernel/mac80211/ ./package/network/config/ -type f -name "mac80211.*")

WIFI_FILE="./package/mtk/applications/mtwifi-cfg/files/mtwifi.sh"

#修改WIFI加密
sed -i "s/encryption=.*/encryption='psk2+ccmp'/g" $WIFI_FILE
#修改WIFI密码
sed -i "/set wireless.default_\${dev}.encryption='psk2+ccmp'/a \\\t\t\t\t\t\set wireless.default_\${dev}.key='password'" $WIFI_FILE

# 给config下的文件增加权限
chmod 644 files/etc/config/*

#更改design主题为白色
# sed -i 's/dark/light/g' feeds/luci/applications/luci-app-design-config/root/etc/config/design

echo "init-settings executed successfully!"
