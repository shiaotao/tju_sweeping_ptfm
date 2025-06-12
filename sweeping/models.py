import uuid
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils import timezone
from .model.model_vehicle import Vehicle
from .model.model_parameter import Parameter

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



# class Schedule(models.Model):
#     id = models.BigAutoField(primary_key=True)  # 显式定义主键字段
#     schedule_id = models.UUIDField(default=uuid.uuid4, editable=False, verbose_name='调度ID')
#     vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE, verbose_name='车辆')
#     route_file_url = models.URLField(verbose_name='线路文件URL')
#     route_name = models.CharField(max_length=100, verbose_name='线路名称')
#     timestamp = models.DateTimeField(auto_now_add=True, verbose_name='调度时间')
#     created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')

#     def __str__(self):
#         return self.route_name

#     class Meta:
#         verbose_name = '调度记录'
#         verbose_name_plural = '调度记录'

# class Operation(models.Model):
#     id = models.BigAutoField(primary_key=True)  # 显式定义主键字段
#     vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE, verbose_name='车辆')
#     schedule = models.ForeignKey(Schedule, on_delete=models.CASCADE, verbose_name='调度记录')
#     operation_date = models.DateField(verbose_name='作业日期')
#     duration = models.DurationField(verbose_name='作业时长')
#     created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')

#     def __str__(self):
#         return f"{self.vehicle.vehicle_number} - {self.operation_date}"

#     class Meta:
#         verbose_name = '作业记录'
#         verbose_name_plural = '作业记录'