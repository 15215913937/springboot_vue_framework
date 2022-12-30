# Statusbar
#
# VERSION    1.0.0
 
# 基础镜像
FROM nginx:1.23.3
# 维护者信息
MAINTAINER qinanshen
 
# 将vue构建后的dist目录中的内容复制到docker容器中nginx默认配置的部署目录
COPY ./dist /usr/share/nginx/html
 
# 将docker容器中默认的配置替换为本地配置
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf
 
# 端口映射
EXPOSE 92