import time
import subprocess
import json
from typing import Optional, Dict, Any
from django.db import models
from django.contrib.auth import get_user_model  # 确保正确导入 get_user_model
from sweeping.model.model_parameter import Parameter  # 修改导入路径
import paho.mqtt.client as mqtt
from threading import Thread, Lock
import logging

class ParameterHistory(models.Model):
    parameter = models.ForeignKey(Parameter, on_delete=models.CASCADE, related_name='history')
    old_value = models.CharField(max_length=255)
    new_value = models.CharField(max_length=255)
    updated_by = models.ForeignKey(get_user_model(), on_delete=models.SET_NULL, null=True, blank=True)  # 确保使用 get_user_model()
    updated_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.parameter.name} - {self.updated_at}"

    class Meta:
        db_table = 'sweeping_parameter_history'  # 显式指定表名


class CalibrationHistory(models.Model):
    """
    标定历史记录模型，用于记录每次标定操作的详细信息
    """
    parameter = models.ForeignKey(
        'sweeping.Parameter',  # 修改：将引用路径改为 'sweeping.Parameter'
        on_delete=models.CASCADE, 
        related_name='calibration_history',  # 添加 related_name 属性
        verbose_name='参数'
    )
    user = models.ForeignKey(get_user_model(), on_delete=models.SET_NULL, null=True, verbose_name='操作用户')
    old_value = models.CharField(max_length=255, verbose_name='修改前的值')
    new_value = models.CharField(max_length=255, verbose_name='修改后的值')
    operation_time = models.DateTimeField(auto_now_add=True, verbose_name='操作时间')
    device_id = models.CharField(max_length=50, blank=True, null=True, verbose_name='设备编号')
    device_type = models.CharField(max_length=50, blank=True, null=True, verbose_name='设备类型')

    class Meta:
        verbose_name = '标定历史记录'
        verbose_name_plural = '标定历史记录'
        db_table = 'sweeping_calibration_history'

    def __str__(self):
        return f"{self.parameter.name} - {self.operation_time}"

    @classmethod
    def create_history(cls, parameter, user, old_value, new_value, device_id=None, device_type=None):
        """
        创建标定历史记录
        :param parameter: 参数对象
        :param user: 操作用户
        :param old_value: 修改前的值
        :param new_value: 修改后的值
        :param device_id: 设备编号（可选）
        :param device_type: 设备类型（可选）
        """
        return cls.objects.create(
            parameter=parameter,
            user=user,
            old_value=old_value,
            new_value=new_value,
            device_id=device_id,
            device_type=device_type
        )

    @classmethod
    def get_all_history(cls):
        """
        获取所有标定历史记录
        :return: 包含所有历史记录的查询集
        """
        return cls.objects.all().order_by('-operation_time')


class DeviceConnectionStatus:
    def __init__(self, device_id: str, device_type: str = "vehicle", ip_address: str = None):
        self.device_id = device_id
        self.device_type = device_type
        self.ip_address = ip_address
        self.is_connected = False
        self.last_checked_time = 0.0
        self.last_heartbeat_time = 0.0
        self.connection_timeout = 30  # 30秒超时
        self.retry_count = 0
        self.max_retries = 3

    def check_connection(self) -> bool:
        """
        检查设备连接状态，包括ping检测和MQTT心跳检测
        """
        try:
            # 1. IP地址ping检测
            if self.ip_address:
                ping_result = self._ping_device()
                if not ping_result:
                    self.is_connected = False
                    self.last_checked_time = time.time()
                    return False

            # 2. MQTT心跳检测
            mqtt_result = self._check_mqtt_heartbeat()
            
            # 3. 综合判断
            self.is_connected = ping_result and mqtt_result
            self.last_checked_time = time.time()
            
            if self.is_connected:
                self.retry_count = 0
            else:
                self.retry_count += 1
                
            return self.is_connected
            
        except Exception as e:
            logging.error(f"设备{self.device_id}连接检测异常: {str(e)}")
            self.is_connected = False
            return False

    def _ping_device(self) -> bool:
        """
        使用ping命令检测设备网络连通性
        """
        try:
            # Windows系统使用-n参数，Linux/Mac使用-c参数
            import platform
            param = '-n' if platform.system().lower() == 'windows' else '-c'
            
            result = subprocess.run(
                ['ping', param, '1', self.ip_address],
                capture_output=True,
                text=True,
                timeout=5
            )
            return result.returncode == 0
        except Exception:
            return False

    def _check_mqtt_heartbeat(self) -> bool:
        """
        检查MQTT心跳状态
        """
        current_time = time.time()
        # 如果超过连接超时时间没有收到心跳，则认为离线
        return (current_time - self.last_heartbeat_time) < self.connection_timeout

    def update_heartbeat(self):
        """
        更新设备心跳时间
        """
        self.last_heartbeat_time = time.time()
        if not self.is_connected:
            self.is_connected = True
            # 触发设备上线事件
            self._trigger_online_event()

    def _trigger_online_event(self):
        """
        触发设备上线事件
        """
        from django.core.signals import Signal
        device_online = Signal()
        device_online.send(sender=self.__class__, device_id=self.device_id)

    def get_status(self) -> str:
        return "在线" if self.is_connected else "离线"

    def get_connection_info(self) -> Dict[str, Any]:
        """
        获取详细的连接信息
        """
        return {
            'device_id': self.device_id,
            'device_type': self.device_type,
            'is_connected': self.is_connected,
            'status': self.get_status(),
            'last_checked_time': self.last_checked_time,
            'last_heartbeat_time': self.last_heartbeat_time,
            'retry_count': self.retry_count,
            'ip_address': self.ip_address
        }


class DeviceConnectionManager:
    _instance = None
    _lock = Lock()

    def __new__(cls):
        if cls._instance is None:
            with cls._lock:
                if cls._instance is None:
                    cls._instance = super().__new__(cls)
        return cls._instance

    def __init__(self):
        if not hasattr(self, 'initialized'):
            self.devices = {}
            self.mqtt_client = None
            self.initialized = True
            self._setup_mqtt_client()

    def _setup_mqtt_client(self):
        """
        设置MQTT客户端用于心跳检测
        """
        try:
            self.mqtt_client = mqtt.Client()
            self.mqtt_client.on_connect = self._on_mqtt_connect
            self.mqtt_client.on_message = self._on_mqtt_message
            self.mqtt_client.connect("broker.emqx.io", 1883, 60)
            self.mqtt_client.loop_start()
        except Exception as e:
            logging.error(f"MQTT客户端初始化失败: {str(e)}")

    def _on_mqtt_connect(self, client, userdata, flags, rc):
        """
        MQTT连接成功回调
        """
        if rc == 0:
            # 订阅所有设备的心跳主题
            client.subscribe("device/+/heartbeat")
            logging.info("MQTT客户端连接成功，已订阅心跳主题")

    def _on_mqtt_message(self, client, userdata, msg):
        """
        接收MQTT心跳消息
        """
        try:
            topic_parts = msg.topic.split('/')
            if len(topic_parts) >= 3 and topic_parts[2] == 'heartbeat':
                device_id = topic_parts[1]
                if device_id in self.devices:
                    self.devices[device_id].update_heartbeat()
                    # 触发WebSocket推送
                    self._broadcast_device_status(device_id)
        except Exception as e:
            logging.error(f"处理MQTT心跳消息异常: {str(e)}")

    def add_device(self, device_id: str, device_type: str = "vehicle", ip_address: str = None):
        """
        添加设备到管理器
        """
        if device_id not in self.devices:
            self.devices[device_id] = DeviceConnectionStatus(device_id, device_type, ip_address)

    def get_device_status(self, device_id: str) -> Optional[str]:
        if device_id in self.devices:
            return self.devices[device_id].get_status()
        return None

    def get_all_devices_status(self) -> Dict[str, Dict[str, Any]]:
        """
        获取所有设备的详细状态信息
        """
        status_dict = {}
        for device_id, device in self.devices.items():
            status_dict[device_id] = device.get_connection_info()
        return status_dict

    def check_all_devices(self):
        """
        检查所有设备连接状态
        """
        for device_id, device in self.devices.items():
            old_status = device.is_connected
            device.check_connection()
            
            # 如果状态发生变化，触发通知
            if old_status != device.is_connected:
                self._broadcast_device_status(device_id)
                if not device.is_connected:
                    self._trigger_offline_notification(device_id)

    def _broadcast_device_status(self, device_id: str):
        """
        通过WebSocket广播设备状态变化
        """
        from channels.layers import get_channel_layer
        from asgiref.sync import async_to_sync
        
        try:
            channel_layer = get_channel_layer()
            if channel_layer:
                device_info = self.devices[device_id].get_connection_info()
                async_to_sync(channel_layer.group_send)(
                    "device_status",
                    {
                        "type": "device_status_update",
                        "device_id": device_id,
                        "status": device_info
                    }
                )
        except Exception as e:
            logging.error(f"WebSocket广播异常: {str(e)}")

    def _trigger_offline_notification(self, device_id: str):
        """
        触发设备离线通知
        """
        device = self.devices.get(device_id)
        if device:
            notification_data = {
                "type": "device_offline",
                "device_id": device_id,
                "device_type": device.device_type,
                "timestamp": time.time(),
                "message": f"设备 {device_id} 已离线"
            }
            
            # 通过WebSocket发送通知
            from channels.layers import get_channel_layer
            from asgiref.sync import async_to_sync
            
            try:
                channel_layer = get_channel_layer()
                if channel_layer:
                    async_to_sync(channel_layer.group_send)(
                        "device_notifications",
                        {
                            "type": "device_notification",
                            "notification": notification_data
                        }
                    )
            except Exception as e:
                logging.error(f"离线通知发送异常: {str(e)}")

# 全局设备连接管理器实例
device_manager = DeviceConnectionManager()

# 启动定时检测任务
def start_device_monitoring():
    """
    启动设备监控任务
    """
    def monitoring_task():
        while True:
            try:
                device_manager.check_all_devices()
                time.sleep(10)  # 每10秒检测一次
            except Exception as e:
                logging.error(f"设备监控任务异常: {str(e)}")
                time.sleep(5)
    
    monitor_thread = Thread(target=monitoring_task, daemon=True)
    monitor_thread.start()

