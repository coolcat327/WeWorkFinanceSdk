# 使用更小python的基础镜像apline
FROM python:3.9-alpine
# 添加 g++ 和其他必要的工具
RUN apk add --no-cache g++ gcc make
# 安装bash
RUN apk add --no-cache bash
# 安装ld-linux-x86-64.so.2和常用的Linux库
RUN apk add --no-cache libstdc++
RUN apk add --no-cache libc6-compat
# 设置工作目录
WORKDIR /app

# 安装依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

# 拷贝项目文件到镜像
COPY . .

# 定时执行 run.sh，并将输出记录到以日期命名的日志
# CMD ["bash", "-c", "while true; do /app/run.sh >> ./log/$(date +%Y-%m-%d).log 2>&1; python3 mvFile.py; sleep 86400; done"]


