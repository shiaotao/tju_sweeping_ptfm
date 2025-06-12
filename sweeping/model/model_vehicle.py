from django.db import models

class Vehicle(models.Model):
    id = models.BigAutoField(primary_key=True)  # 显式定义主键字段
    vin_code = models.CharField(max_length=17, unique=True, verbose_name='VIN码')
    vehicle_number = models.CharField(max_length=20, verbose_name='车辆编号')
    license_plate = models.CharField(max_length=10, verbose_name='车牌号')
    manufacturer = models.CharField(max_length=50, verbose_name='生产厂家')
    brand = models.CharField(max_length=50, verbose_name='品牌')
    operation_date = models.DateField(verbose_name='投入运营日期')
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    # user = models.ForeignKey('User', on_delete=models.CASCADE)

    def __str__(self):
        return self.vehicle_number

    class Meta:
        verbose_name = '车辆'
        verbose_name_plural = '车辆'