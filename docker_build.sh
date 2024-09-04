# 获取时间保存到time变量
time=$(date +%Y%m%d%H%M)
#指定linux/amd64平台打包镜像，并使用gzip压缩
docker buildx build --platform linux/amd64 -t wx_history:1.0 --compress .
# 保存并gzip压缩镜像，镜像tag和镜像文件名为时间相关
docker save wx_history:1.0 | gzip > wx_history_$time.tar.gz