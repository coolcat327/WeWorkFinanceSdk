import os
import shutil
import datetime
# 获取当前目录下所有扩展名为.xlsx和.jsonl的文件路径
files = [f for f in os.listdir('.') if f.endswith(('.xlsx', '.jsonl'))]

# 如果fiels不为空，则将文件移动到dir_path目录下
if files:
    # 获取今天的日期和时间集体到分钟
    today = datetime.datetime.now().strftime('%Y%m%d%H%M')
    # 在data目录下新建以今天日期为名称的目录
    dir_path = os.getcwd() + 'data/chat_data/' + today
    os.makedirs(dir_path, exist_ok=True)
    for file in files:
        shutil.move(file, dir_path)
else:
    print('没有找到文件不移动')

