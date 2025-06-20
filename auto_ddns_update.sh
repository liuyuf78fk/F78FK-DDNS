#!/bin/bash

# ========== 可配置变量 ==========
ZONE="example.com"
FQDN="www.example.com."
KEY="/home/user/ddns/ddns.key"
TYPE="A"
TTL="600"
DDNS_SCRIPT="/home/user/ddns/f78fk.ddns_update.sh"
GET_IP_SCRIPT="/home/user/ddns/getip.sh"
LOG=true
# =================================

# 获取当前 IP
CURRENT_IP=$("$GET_IP_SCRIPT" 2>/dev/null | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$')

# 检查 IP 是否获取成功
if [ -z "$CURRENT_IP" ]; then
  MSG="$(date +'%F %T') 获取 IP 失败，跳过 DDNS 更新"
  echo "$MSG"
  [ "$LOG" == "true" ] && echo "$MSG" >> /var/log/f78fk.ddns.log
  exit 1
fi

# 执行 DDNS 更新（是否启用日志由 LOG 变量控制）
if [ "$LOG" == "true" ]; then
  LOG=true "$DDNS_SCRIPT" "$ZONE" "$FQDN" "$KEY" "$TYPE" "$TTL" "$CURRENT_IP"
else
  "$DDNS_SCRIPT" "$ZONE" "$FQDN" "$KEY" "$TYPE" "$TTL" "$CURRENT_IP"
fi
