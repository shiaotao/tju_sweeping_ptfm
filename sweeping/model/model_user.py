from django.db import models
from django.contrib.auth.models import AbstractUser
class User(AbstractUser):
    id = models.BigAutoField(primary_key=True)  # 显式定义主键字段
    username = models.CharField(max_length=17, unique=True, verbose_name='用户名')
    password = models.CharField(max_length=180, verbose_name='密码')
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    updated_at = models.DateTimeField(auto_now_add=True, verbose_name='更新时间')
     # 添加 related_name 参数以避免冲突
    groups = models.ManyToManyField(
        'auth.Group',
        related_name='sweeping_user_groups',  # 自定义反向访问器名称
        blank=True,
        help_text='The groups this user belongs to.',
        verbose_name='groups'
    )
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        related_name='sweeping_user_permissions',  # 自定义反向访问器名称
        blank=True,
        help_text='Specific permissions for this user.',
        verbose_name='user permissions'
    )
