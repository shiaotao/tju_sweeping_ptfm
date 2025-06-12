TJU - ESTATES OFFICE Sweeping Platform - Section 2
---

# 1 Packages

| Package           | Version |
| ----------------- | ------- |
| Python            | 3.9.11  |
| asgiref           | 3.8.1   |
| Django            | 4.1.2   |
| mysqlclient       | 2.2.7   |
| paho-mqtt         | 1.6.1   |
| setuptools        | 58.1.0  |
| sqlparse          | 0.5.3   |
| typing_extensions | 4.13.2  |
| tzdata            | 2025.2  |


# 2 References

MySQL :: MySQL 5.7 参考文档 :: 2.3 在 Microsoft Windows 上安装MySQL
> https://dev.mysql.com/doc/refman/5.7/en/windows-installation.html

## 生成迁移文件
```python manage.py makemigrations```

## 应用迁移文件
```python manage.py migrate```

## 启动工程
```python manage.py runserver```