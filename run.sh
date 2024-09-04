#!/bin/bash
# 判断data文件夹下如果不存在voice文件夹，video文件夹，image文件夹，file文件夹，chat_data文件夹,call文件夹，则创建
# 定义需要创建的子目录列表
directories=("data/voice" "data/video" "data/image" "data/file" "data/chat_data" "data/call")

# 创建顶层目录
if [ ! -d "data" ]; then
    mkdir data
    if [ $? -ne 0 ]; then
        echo "Failed to create directory 'data'"
        exit 1
    fi
fi

# 创建子目录
for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir "$dir"
        if [ $? -ne 0 ]; then
            echo "Failed to create directory '$dir'"
            exit 1
        fi
    fi
done

start_time=$(date +"%Y-%m-%d %T")
# 判断如果不存在sdktools文件，则使用g++ C_sdk/sdktools.cpp -ldl -o sdktools编译
if [ ! -f "sdktools" ]; then
    echo "sdktools文件不存在，开始编译sdktools"
    g++ C_sdk/tool_testSdk_new.cpp -ldl -o sdktools
fi

if [ -f "chat.jsonl" ] || [ -f "chatdata.jsonl" ]; then
    echo "chat.jsonl 或 chatdata.jsonl 文件已存在，请先备份或删除"
    exit 1
else
    python3 WxChat.py
fi

if [ -f "chatdata.jsonl" ]; then
    python3 chatMsg.py

else
    echo "chatdata.jsonl 文件不存在，请先执行 WxChat.py"
    exit 1
fi

if [ -f "chat_list.xlsx" ]; then
    python3 getFile.py
else
    echo "chat_list.xlsx 文件不存在，请先执行 chatMsg.py"
fi

python3 mvFile.py

end_time=$(date +"%Y-%m-%d %T")
echo "任务开始执行时间：$start_time"
echo "任务执行结束时间：$end_time"