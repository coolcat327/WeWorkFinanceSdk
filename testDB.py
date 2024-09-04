import pandas as pd
import pymysql
from dotenv import dotenv_values
from sqlalchemy import create_engine
import os
# 从 .env 文件中读取数据库连接配置
# db_config = dotenv_values('.env')
db_config = {
        'DB_HOST': os.getenv('DB_HOST'),
        'DB_USER': os.getenv('DB_USER'),
        'DB_PASSWORD': os.getenv('DB_PASSWORD'),
        'DB_NAME': os.getenv('DB_NAME'),
        'DB_PORT': os.getenv('DB_PORT'),
        'SAVE_TO_DB': os.getenv('SAVE_TO_DB')
    }
# 创建 DataFrame
data = {
    'Name': ['Alice', 'Bob', 'Charlie'],
    'Age': [25, 30, 35],
    'City': ['New York', 'London', 'Paris']
}
df = pd.DataFrame(data)

try:
    # 创建 MySQL 数据库连接字符串
    connection_string = f"mysql+pymysql://{db_config['DB_USER']}:{db_config['DB_PASSWORD']}@{db_config['DB_HOST']}:{db_config['DB_PORT']}/{db_config['DB_NAME']}"

    # 创建数据库连接引擎
    engine = create_engine(connection_string)

    # 将 DataFrame 写入 MySQL 数据库的表中
    df.to_sql(name='test', con=engine, if_exists='replace', index=False)

    # 关闭数据库连接
    engine.dispose()

    print("数据写入成功！")

except pymysql.Error as e:
    print(f"数据库连接错误：{e}")
