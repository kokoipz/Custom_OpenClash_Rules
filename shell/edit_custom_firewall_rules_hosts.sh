#!/bin/sh

# 目标文件路径
TARGET_FILE="/etc/openclash/custom/openclash_custom_firewall_rules.sh"

# 要插入的内容
INSERT_CONTENT=$(cat << EOF
# ==============以下是广告过滤规则拉取脚本=================
# 以下是 GitHub520 加速规则拉取脚本
# 以下是 GitHub520 加速规则拉取脚本
LOG_OUT "拉取GitHub520加速规则…"
sed -i '/# GitHub520 Host Start/,/# GitHub520 Host End/d' /etc/hosts
curl https://raw.hellogithub.com/hosts | \
    sed '/127.0.0.1 localhost/d; /::1 localhost/d; 1s/^/# GitHub520 Host Start\n/; $s/$/\n# GitHub520 Host End/' >> /etc/hosts
sed -i '/^$/d' /etc/hosts
sed -i '/!/d' /etc/hosts
# GitHub520 加速规则拉取脚本结束
# 清理 DNS 缓存
LOG_OUT "清理 DNS 缓存…"
/etc/init.d/dnsmasq reload
# 以下是广告过滤规则拉取脚本
LOG_OUT "拉取秋风广告过滤规则…"
sed -i '/# AWAvenue-Ads-Rule Start/,/# AWAvenue-Ads-Rule End/d' /etc/hosts
curl https://github.boki.moe/https://raw.githubusercontent.com/TG-Twilight/AWAvenue-Ads-Rule/main/Filters/AWAvenue-Ads-Rule-hosts.txt | \
    sed '/127.0.0.1 localhost/d; /::1 localhost/d; 1s/^/# AWAvenue-Ads-Rule Start\n/; $s/$/\n# AWAvenue-Ads-Rule End/' >> /etc/hosts
sed -i '/^$/d' /etc/hosts
sed -i '/!/d' /etc/hosts
# 广告过滤规则拉取脚本结束
# 清理 DNS 缓存
LOG_OUT "清理 DNS 缓存…"
/etc/init.d/dnsmasq reload
# ==============广告过滤规则拉取脚本结束==============
EOF
)

# 检查目标文件是否存在
if [ ! -f "$TARGET_FILE" ]; then
  echo "目标文件不存在: $TARGET_FILE"
  exit 1
fi

# 确保目标文件以换行符结尾
sed -i -e '$a\' "$TARGET_FILE"

# 清除指定范围内容（LOG_OUT 到 exit 0 之间的内容）
awk '
BEGIN {skip=0}
/LOG_OUT "Tip: Start Add Custom Firewall Rules..."/ {print; skip=1; next}
/exit 0/ {skip=0}
!skip
' "$TARGET_FILE" > "${TARGET_FILE}.tmp" && mv "${TARGET_FILE}.tmp" "$TARGET_FILE"

# 插入新内容
awk -v content="$INSERT_CONTENT" '
/LOG_OUT "Tip: Start Add Custom Firewall Rules..."/ {
    print;
    print content;
    next;
}
1
' "$TARGET_FILE" > "${TARGET_FILE}.tmp" && mv "${TARGET_FILE}.tmp" "$TARGET_FILE"

echo "Github520 Hosts 拉取代码已写入到“开发者选项”文件 $TARGET_FILE 中，并将在 OpenClash 下次启动时生效！"
