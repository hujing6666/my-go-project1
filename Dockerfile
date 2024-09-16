# 使用 golang:1.23-alpine 镜像作为基础镜像
FROM golang:1.23-alpine AS builder

# 设置工作目录
WORKDIR /app

# 克隆项目并构建
RUN apk update && apk add --no-cache git bash
RUN git clone https://$GIT_USERNAME:$GIT_TOKEN@github.com/hujing6666/my-go-project1.git
WORKDIR /app/my-go-project1
RUN git checkout master
# 确保 go.mod 文件中的依赖项正确
RUN go mod tidy
# 下载 Go 模块
RUN go mod download
# 构建 Go 应用
RUN go build -o /app/main .

# 创建最终镜像
FROM alpine:3.18

# 安装 Nginx 和 Redis
RUN apk update && apk add --no-cache nginx redis bash ca-certificates

# 下载 etcd 的二进制文件
RUN apk add --no-cache wget
COPY etcd/etcd-v3.5.5-linux-amd64.tar.gz /tmp/
RUN tar xvf /tmp/etcd-v3.5.5-linux-amd64.tar.gz \
    && mv etcd-v3.5.5-linux-amd64/etcd* /usr/local/bin/ \
    && rm -rf etcd-v3.5.5-linux-amd64* \
    && rm /tmp/etcd-v3.5.5-linux-amd64.tar.gz



# 复制 Nginx 配置和启动脚本
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# 复制 Go 可执行文件
COPY --from=builder /app/main /usr/local/bin/main

# 暴露端口
EXPOSE 9091
EXPOSE 6479
EXPOSE 2479

# 启动脚本
CMD ["/usr/local/bin/start.sh"]
