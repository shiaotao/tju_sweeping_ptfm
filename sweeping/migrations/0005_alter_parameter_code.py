# Generated by Django 4.1.2 on 2025-05-30 08:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("sweeping", "0004_alter_parameter_options_and_more"),
    ]

    operations = [
        migrations.AlterField(
            model_name="parameter",
            name="code",
            field=models.CharField(max_length=5, verbose_name="数据类型"),
        ),
    ]
