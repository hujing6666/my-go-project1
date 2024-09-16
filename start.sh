#!/bin/sh

# 启动 Redis
redis-server &

# 启动 etcd
etcd &

# 启动 Nginx
nginx &

# 启动 Go 应用
/usr/local/bin/main &

# 确保容器在前台运行
wait