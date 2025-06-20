#!/bin/bash

# 获取当前公网 IP 地址
# 默认使用自建接口 https://ip.f78fk.com 可避免第三方服务变动或限速带来的影响。  
#      你也可以根据实际网络情况，选择距离你服务器更近的 API 接口。
#
# Fetch the current public IPv4 address using our own API at https://ip.f78fk.com.
#      This avoids dependency on external services and ensures better stability.
#      You may also replace this with a nearby API service for better latency or reliability.
#

curl -s -4 https://ip.f78fk.com?format=text | grep '^Current IP:' | sed 's/^Current IP:[[:space:]]*//'
