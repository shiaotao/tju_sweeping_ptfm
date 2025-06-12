'''
Author      : Shiaotao_Guo
Date        : 2025-05-22 18:12:39
LastEditors : Shiaotao_Guo | 1024201174 guoxiaotao@tju.edu.cn
LastEditTime: 2025-05-30 16:40:04
FilePath    : /S2548001/sweeping/model/model_parameter.py
Description : 
Reference   : 
'''
from django.db import models

class Parameter(models.Model):
    id = models.BigAutoField(unique=True, primary_key=True)     # 定义主键字段
    oid = models.BigIntegerField(default=-1, max_length=19, verbose_name='上一记录')
    cid = models.BigIntegerField(default=-1, max_length=19, verbose_name='下一记录')
    name = models.CharField(max_length=99, verbose_name='参数名')

    code = models.CharField(
        max_length=5, verbose_name='数据类型')
    
    NUM_SYS_CHOICES = [
        ('b', '二进制'),
        ('o', '八进制'),
        ('d', '十进制'),
        ('h', '十六进制')
    ]
    nst = models.CharField(
        max_length=1, choices=NUM_SYS_CHOICES, verbose_name='进制'
    )

    value = models.CharField(max_length=99, verbose_name='参数值')
    unit = models.CharField(max_length=9, verbose_name='单位')

    PARAM_STATE_CHOICES = [
        ('0', '仅提交'),
        ('1', '已标定'),
        ('2', '出错')
    ]
    state = models.CharField(
        max_length=1, choices=PARAM_STATE_CHOICES, verbose_name='标定状态'
    )

    created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    update_at = models.DateTimeField(auto_now=True, verbose_name='更新时间')
    user = models.ForeignKey(
        'User', on_delete=models.SET_NULL, null=True, blank=True, verbose_name='操作人'
    )
    device_id = models.BigIntegerField(max_length=19, verbose_name='目标设备')
    
    DEVICE_TYPE_CHOICES = [
        ('vehicle', '清扫车'),
        ('ship', '清洁船'),
        ('uav', '无人机')
    ]
    device_type = models.CharField(
        max_length=7, choices=DEVICE_TYPE_CHOICES, verbose_name='设备类型'
    )

    description = models.CharField(
        max_length=200, null=True, blank=True, verbose_name='参数描述'
    )
    is_active = models.BooleanField(default=True, verbose_name='启用标志')

    def __str__(self):
        return f"({self.id})"

    class Meta:
        db_table = 'sweeping_parameters'
        ordering = ['name', '-update_at']
        verbose_name = '参数'
        verbose_name_plural = '参数簇'