# Generated by Django 4.1.2 on 2025-05-30 07:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sweeping', '0004_parameter_delete_calibrationparameter'),
    ]

    operations = [
        migrations.AlterField(
            model_name='parameter',
            name='unit',
            field=models.CharField(default='', max_length=10, verbose_name='单位'),
        ),
    ]
