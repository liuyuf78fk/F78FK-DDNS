#!/bin/bash

# 参数校验
if [ $# -ne 6 ]; then
  echo "用法: $0 <zone> <fqdn> <key-path> <type> <ttl> <value>"
  echo "示例: $0 example.com www.example.com. /home/user/ddns/ddns.key A 600 1.2.3.4"
  exit 1
fi

ZONE="$1"
FQDN="$2"
KEY="$3"
TYPE="$4"
TTL="$5"
VALUE="$6"

SERVER="ns1.f78fk.net"
QUERY_DNS="1.1.1.1"
LOG_FILE="/var/log/f78fk.ddns.log"
LOG="${LOG:-false}"  # 默认不开日志，除非手动 export LOG=true

# 获取当前记录值
CURRENT_VALUE=$(dig +short +time=1 +tries=1 "$FQDN" "$TYPE" @"$QUERY_DNS" | grep -E "^[0-9a-fA-F.:]+$")

# 检查是否查询失败
if [ -z "$CURRENT_VALUE" ]; then
  MSG="获取 [$FQDN $TYPE] 当前记录失败"
  echo "$MSG"
  [ "$LOG" == "true" ] && echo "$(date +'%F %T') [ERROR] $MSG" >> "$LOG_FILE"
  exit 1
fi

# 判断是否相同
if [ "$CURRENT_VALUE" == "$VALUE" ]; then
  MSG="记录 [$FQDN $TYPE] 已是 [$VALUE]，无需更新"
  echo "$MSG"
  [ "$LOG" == "true" ] && echo "$(date +'%F %T') [SKIP] $MSG" >> "$LOG_FILE"
  exit 0
fi

# 检查 key 是否存在
if [ ! -f "$KEY" ]; then
  echo "错误：密钥文件不存在: $KEY"
  exit 2
fi

FQDN_DOT="${FQDN%.}."

# 执行 nsupdate 更新
nsupdate -k "$KEY" <<EOF
server $SERVER
zone $ZONE
update delete $FQDN_DOT $TYPE
update add $FQDN_DOT $TTL $TYPE $VALUE
send
EOF

MSG="已更新 [$FQDN $TYPE] 为 [$VALUE]（TTL $TTL）"
echo "$MSG"
[ "$LOG" == "true" ] && echo "$(date +'%F %T') [UPDATE] $MSG" >> "$LOG_FILE"
