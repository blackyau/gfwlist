#!/bin/sh
curl https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt > gfwlist.txt
base64 -i -d gfwlist.txt > gfwlist_raw.txt # 解码为明文
sed -i '$d' gfwlist_raw.txt && sed -i '$d' gfwlist_raw.txt # 删除最后两行的EOF，要在后面添加新内容
cat custom.txt >> gfwlist_raw.txt # 自定义配置写入 gfwlist
sed -i '/! Checksum:/d' gfwlist_raw.txt # 删除 Checksum
sed -i 's/! Expires: 6h/! Expires: 72h/' gfwlist_raw.txt # 延长更新时间
nowtime=$(date "+%Y-%m-%d %H:%M:%S")
sed -i "s/! Last Modified: Mon, 04 Nov 2019 11:21:47 -0500/! Last Modified: $nowtime/" gfwlist_raw.txt
