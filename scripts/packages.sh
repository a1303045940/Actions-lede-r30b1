#!/bin/bash

#删除feeds中的插件
# rm -rf ./feeds/ssrp/ipt2socks
# rm -rf ./feeds/ssrp/hysteria
# rm -rf ./feeds/ssrp/v2ray-plugin
# rm -rf ./feeds/ssrp/chinadns-ng
# rm -rf ./feeds/ssrp/dns2tcp
# rm -rf ./feeds/ssrp/naiveproxy
# rm -rf ./feeds/ssrp/shadowsocksr-libev
# rm -rf ./feeds/ssrp/v2ray-plugin
# rm -rf ./feeds/packages/net/smartdns
rm -rf ./feeds/packages/net/chinadns-ng
rm -rf ./feeds/packages/net/sing-box
rm -rf ./feeds/packages/net/xray-core
# rm -rf ./feeds/luci/applications/luci-app-mosdns
# rm -rf ./feeds/luci/applications/luci-app-smartdns
rm -rf ./feeds/luci/applications/luci-app-passwall
rm -rf ./feeds/luci/applications/luci-app-passwall2
rm -rf ./feeds/luci/applications/luci-app-openclash

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}




#克隆插件
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/pwpage


mkdir package/small
pushd package/small
#adguardhome
# git clone -b 2023.10 --depth 1 https://github.com/XiaoBinin/luci-app-adguardhome.git
#lucky
# git clone -b main --depth 1 https://github.com/sirpdboy/luci-app-lucky.git
#smartdns
# git clone -b lede --depth 1 https://github.com/pymumu/luci-app-smartdns.git
# git clone -b master --depth 1 https://github.com/pymumu/smartdns.git
#ssrp
git clone -b master --depth 1 https://github.com/fw876/helloworld.git
#passwall
git clone -b main --depth 1 https://github.com/xiaorouji/openwrt-passwall.git
#passwall2
git clone -b main --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git
#mosdns
# git clone -b v5 --depth 1 https://github.com/sbwml/luci-app-mosdns.git
#openclash
git clone -b master --depth 1 https://github.com/vernesong/OpenClash.git
#modem
# git clone -b main --depth 1 https://github.com/FUjr/modem_feeds.git

#UPDATE_PACKAGE "luci-app-npc" "kiddin9/kwrt-packages" "main" "pkg"

# iStore
git_sparse_clone main https://github.com/linkease/istore-ui app-store-ui
git_sparse_clone main https://github.com/linkease/istore luci

git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-npc
git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-frpc
git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-zerotier
git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-theme-argon


#git clone -b main --depth 1 https://github.com/a1303045940/luci-app-npc.git
#UPDATE_PACKAGE "luci-app-frpc" "kiddin9/kwrt-packages" "main" "pkg"
#git clone -b main --depth 1 https://github.com/kiddin9/kwrt-packages/luci-app-frpc.git


popd

echo "packages executed successfully!"

# 调整 ZeroTier 到 服务 菜单
#sed -i 's/vpn/services/g; s/VPN/Services/g' feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua
#sed -i 's/vpn/services/g' feeds/luci/applications/luci-app-zerotier/luasrc/view/zerotier/zerotier_status.htm

