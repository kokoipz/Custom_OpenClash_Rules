#!/bin/sh

echo "拉取GitHub520加速规则…"
sed -i '/# GitHub520 Host Start/,/# GitHub520 Host End/d' /etc/hosts
curl https://ghkkz.440222.xyz/https://raw.hellogithub.com/hosts >> /etc/hosts
sed -i '/^$/d' /etc/hosts
sed -i '/!/d' /etc/hosts
# GitHub520 加速规则拉取脚本结束
# 清理 DNS 缓存
echo "清理 DNS 缓存…"
/etc/init.d/dnsmasq reload
# 以下是广告过滤规则拉取脚本
echo "拉取秋风广告过滤规则…"
sed -i '/# AWAvenue-Ads-Rule Start/,/# AWAvenue-Ads-Rule End/d' /etc/hosts
curl https://ghkkz.440222.xyz/https://raw.githubusercontent.com/TG-Twilight/AWAvenue-Ads-Rule/main/Filters/AWAvenue-Ads-Rule-hosts.txt | \
    sed '/127.0.0.1 localhost/d; /::1 localhost/d; 1s/^/# AWAvenue-Ads-Rule Start\n/; $s/$/\n# AWAvenue-Ads-Rule End/' >> /etc/hosts
sed -i '/^$/d' /etc/hosts
sed -i '/!/d' /etc/hosts
# 广告过滤规则拉取脚本结束
# 清理 DNS 缓存
echo "清理 DNS 缓存…"
/etc/init.d/dnsmasq reload

