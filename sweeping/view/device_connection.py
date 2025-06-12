from django.http import JsonResponse
from django.views.decorators.http import require_http_methods
from django.views.decorators.csrf import csrf_exempt
from sweeping.model.model_parameters import DeviceConnectionManager, device_manager
import json
import logging
import time

def device_connection_status(request):
    """
    获取所有设备连接状态
    """
    try:
        all_status = device_manager.get_all_devices_status()
        return JsonResponse({
            'status': 'success',
            'devices': all_status,
            'timestamp': time.time()
        })
    except Exception as e:
        logging.error(f"获取设备状态异常: {str(e)}")
        return JsonResponse({
            'status': 'error',
            'message': str(e)
        }, status=500)

@require_http_methods(["GET"])
def check_device_connection(request, device_id):
    """
    检测特定设备连接状态
    """
    try:
        device_status = device_manager.get_device_status(device_id)
        if device_status is None:
            return JsonResponse({
                'status': 'error',
                'message': '设备不存在'
            }, status=404)
        
        # 强制检测一次
        if device_id in device_manager.devices:
            device_manager.devices[device_id].check_connection()
            device_info = device_manager.devices[device_id].get_connection_info()
        else:
            device_info = {'is_connected': False, 'status': '未知'}
        
        return JsonResponse({
            'status': 'success',
            'device_info': device_info
        })
    except Exception as e:
        logging.error(f"检测设备连接异常: {str(e)}")
        return JsonResponse({
            'status': 'error',
            'message': str(e)
        }, status=500)

@csrf_exempt
@require_http_methods(["POST"])
def add_device_to_monitor(request):
    """
    添加设备到监控列表
    """
    try:
        data = json.loads(request.body)
        device_id = data.get('device_id')
        device_type = data.get('device_type', 'vehicle')
        ip_address = data.get('ip_address')
        
        if not device_id:
            return JsonResponse({
                'status': 'error',
                'message': '设备ID不能为空'
            }, status=400)
        
        device_manager.add_device(device_id, device_type, ip_address)
        
        return JsonResponse({
            'status': 'success',
            'message': f'设备 {device_id} 已添加到监控列表'
        })
    except Exception as e:
        logging.error(f"添加设备监控异常: {str(e)}")
        return JsonResponse({
            'status': 'error',
            'message': str(e)
        }, status=500)
