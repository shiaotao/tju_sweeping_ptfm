from django.apps import AppConfig

class SweepingConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'sweeping'

    def ready(self):
        # 启动设备监控
        from .model.model_parameters import start_device_monitoring, device_manager
        
        # 添加一些示例设备到监控
        device_manager.add_device("vehicle_001", "vehicle", "192.168.1.100")
        device_manager.add_device("uav_001", "uav", "192.168.1.101")
        device_manager.add_device("ship_001", "ship", "192.168.1.102")
        
        # 启动监控线程
        start_device_monitoring()