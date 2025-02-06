#!/bin/sh

# 删除已存在的 adblockfilters 规则文件
rm /tmp/dnsmasq.cfg01411c.d/adblockfilters-for-dnsmasq.conf
echo "拉取 anti-AD 广告过滤规则…"
# 注意自行核实 /tmp 下的 dnsmasq.d 文件夹名称，并修改对应代码  
curl -s "https://gh-proxy.com/https://raw.githubusercontent.com/217heidai/adblockfilters/main/rules/adblockdnsmasq.txt" -o /tmp/dnsmasq.cfg01411c.d/adblockfilters-for-dnsmasq.conf
# 广告过滤规则拉取脚本结束
# 清理 DNS 缓存，v0.46.043 之前版本无需此步骤
echo "清理 DNS 缓存…"
/etc/init.d/dnsmasq reload
/etc/init.d/dnsmasq restart
