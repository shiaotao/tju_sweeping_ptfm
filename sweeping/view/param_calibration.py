from django.shortcuts import render, redirect
from django.contrib import messages
from django.views.decorators.csrf import csrf_exempt
from sweeping.model.model_parameter import Parameter
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
import json
from sweeping.model.model_parameters import ParameterHistory
from django.utils import timezone

@login_required
def calibration_history(request):
    # 查询所有标定历史记录
    history_records = ParameterHistory.objects.all().order_by('-updated_at')
    return render(request, 'calibration_history.html', {'history_records': history_records})

@login_required
def param_calibration(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        code = request.POST.get('code')
        value = request.POST.get('value')
        unit = request.POST.get('unit')
        description = request.POST.get('description')
        is_active = request.POST.get('is_active') == 'on'
        device_id = request.POST.get('device_id')
        device_type = request.POST.get('device_type')
        
        Parameter.objects.create(
            name=name,
            code=code,
            value=value,
            unit=unit,
            description=description,
            is_active=is_active,
            device_id=device_id,
            device_type=device_type
        )
        messages.success(request, '参数添加成功。')
        return redirect('param_calibration')
    
    from sweeping.model.model_vehicle import Vehicle
    # 获取设备类型参数
    device_type = request.GET.get('device_type', None)
    
    # 根据设备类型筛选参数
    if device_type:
        parameters = Parameter.objects.filter(device_type=device_type)
    else:
        parameters = Parameter.objects.all()
    
    vehicles = Vehicle.objects.all()
    return render(request, 'param_calibration.html', {'parameters': parameters, 'vehicles': vehicles})

@login_required
def add_parameter(request):
    print("add_parameter")
    if request.method == 'POST':
        name = request.POST.get('name')
        code = request.POST.get('code')
        value = request.POST.get('value')
        unit = request.POST.get('unit')
        description = request.POST.get('description')
        is_active = request.POST.get('is_active') == 'on'
        device_id = request.POST.get('device_id')
        device_type = request.POST.get('device_type')
        
        Parameter.objects.create(
            name=name,
            code=code,
            value=value,
            unit=unit,
            description=description,
            is_active=is_active,
            device_id=device_id,
            device_type=device_type
        )
        messages.success(request, '参数添加成功。')
        return redirect('param_calibration')
    
    return render(request, 'add_parameter.html')

@login_required
def calib_edit_parameter(request, parameter_id):
    parameter = Parameter.objects.get(id=parameter_id)
    if request.method == 'POST':
        # 记录标定历史
        old_value = parameter.value  # 获取旧值
        new_value = request.POST.get('value')  # 获取新值
        
        # 更新参数对象
        parameter.name = request.POST.get('name')  # 确保 name 字段有值
        parameter.code = request.POST.get('code')
        parameter.value = new_value
        parameter.unit = request.POST.get('unit')
        parameter.description = request.POST.get('description')
        parameter.is_active = request.POST.get('is_active') == 'on'
        parameter.device_id = request.POST.get('device_id')
        parameter.device_type = request.POST.get('device_type')
        parameter.save()
        
        # 显式解析 request.user
        if request.user.is_authenticated:
            updated_by = request.user  # 确保传递的是真实的 User 实例
        else:
            updated_by = None  # 匿名用户处理

        # 创建 ParameterHistory 记录
        ParameterHistory.objects.create(
            parameter=parameter,
            old_value=old_value,
            new_value=new_value,
            updated_by=updated_by  # 使用解析后的用户实例
        )
        
        messages.success(request, '参数更新成功。')
        return redirect('param_calibration')
    
    return render(request, 'edit_parameter.html', {'parameter': parameter})

'''
@login_required
def delete_parameter(request, parameter_id):
    print(parameter_id)
    parameter = Parameter.objects.get(id=parameter_id)
    parameter.delete()
    messages.success(request, '参数删除成功。')
    return redirect('calibration_management')

@login_required
def get_parameter_data(request, parameter_id):
    try:
        parameter = Parameter.objects.get(id=parameter_id)
        data = {
            'id': parameter.id,
            'name': parameter.name,
            'code': parameter.code,
            'value': parameter.value,
            'unit': parameter.unit,
            'description': parameter.description,
            'is_active': parameter.is_active,
            'device_id': parameter.device_id,
            'device_type': parameter.device_type
        }
        return JsonResponse(data)
    except Parameter.DoesNotExist:
        return JsonResponse({'error': 'Parameter not found'}, status=404)
'''

@login_required
def batch_delete_parameters(request):
    if request.method == 'POST':
        try:
            # 从POST请求中获取要删除的参数ID列表
            parameter_ids = json.loads(request.POST.get('parameter_ids', '[]'))
            
            if not parameter_ids:
                return JsonResponse({'status': 'error', 'message': '未选择任何参数'}, status=400)
            
            # 删除选中的参数
            deleted_count = 0
            for param_id in parameter_ids:
                try:
                    parameter = Parameter.objects.get(id=param_id)
                    parameter.delete()
                    deleted_count += 1
                except Parameter.DoesNotExist:
                    continue
            
            messages.success(request, f'成功删除{deleted_count}个参数。')
            return JsonResponse({'status': 'success', 'message': f'成功删除{deleted_count}个参数。'})
        except Exception as e:
            return JsonResponse({'status': 'error', 'message': f'删除失败: {str(e)}'}, status=500)
    
    return JsonResponse({'status': 'error', 'message': '不支持的请求方法'}, status=405)

@login_required
def validate_parameter_value(request):
    if request.method == 'POST':
        parameter_id = request.POST.get('parameter_id')
        value = request.POST.get('value')
        device_id = request.POST.get('device_id')
        
        try:
            parameter = Parameter.objects.get(id=parameter_id)
            
            # 1. 基础校验
            validation_result = _basic_parameter_validation(parameter, value)
            if not validation_result['is_valid']:
                return JsonResponse(validation_result)
            
            # 2. 设备连接状态校验
            device_check_result = _check_device_connection_for_parameter(device_id)
            if not device_check_result['is_valid']:
                return JsonResponse(device_check_result)
            
            # 3. 参数依赖关系校验
            dependency_check_result = _check_parameter_dependencies(parameter, value)
            if not dependency_check_result['is_valid']:
                return JsonResponse(dependency_check_result)
            
            # 4. 设备特定校验
            device_specific_result = _device_specific_validation(parameter, value, device_id)
            if not device_specific_result['is_valid']:
                return JsonResponse(device_specific_result)
            
            return JsonResponse({
                'status': 'success', 
                'message': '参数值校验通过',
                'validation_details': {
                    'basic_check': '通过',
                    'device_connection': '通过',
                    'dependency_check': '通过',
                    'device_specific': '通过'
                }
            })
        
        except Parameter.DoesNotExist:
            return JsonResponse({'status': 'error', 'message': '参数不存在'}, status=404)
        except Exception as e:
            return JsonResponse({'status': 'error', 'message': f'校验异常: {str(e)}'}, status=500)
    
    return JsonResponse({'status': 'error', 'message': '不支持的请求方法'}, status=405)

def _basic_parameter_validation(parameter, value):
    if not value:
        return {'is_valid': False, 'status': 'error', 'message': '参数值不能为空'}
    
    # 根据参数类型进行校验
    param_type = getattr(parameter, 'type', 'str')
    
    if param_type == 'int':
        try:
            int_value = int(value)
            if hasattr(parameter, 'min_value') and parameter.min_value is not None:
                if int_value < parameter.min_value:
                    return {'is_valid': False, 'status': 'error', 'message': f'参数值必须大于等于 {parameter.min_value}'}
            if hasattr(parameter, 'max_value') and parameter.max_value is not None:
                if int_value > parameter.max_value:
                    return {'is_valid': False, 'status': 'error', 'message': f'参数值必须小于等于 {parameter.max_value}'}
        except ValueError:
            return {'is_valid': False, 'status': 'error', 'message': '参数值必须是有效的整数'}
    
    elif param_type == 'float':
        try:
            float_value = float(value)
            if hasattr(parameter, 'min_value') and parameter.min_value is not None:
                if float_value < parameter.min_value:
                    return {'is_valid': False, 'status': 'error', 'message': f'参数值必须大于等于 {parameter.min_value}'}
            if hasattr(parameter, 'max_value') and parameter.max_value is not None:
                if float_value > parameter.max_value:
                    return {'is_valid': False, 'status': 'error', 'message': f'参数值必须小于等于 {parameter.max_value}'}
        except ValueError:
            return {'is_valid': False, 'status': 'error', 'message': '参数值必须是有效的数字'}
    
    elif param_type == 'bool':
        if value.lower() not in ['true', 'false', '1', '0']:
            return {'is_valid': False, 'status': 'error', 'message': '布尔参数值必须是 true/false 或 1/0'}
    
    return {'is_valid': True}

def _check_device_connection_for_parameter(device_id):
    if not device_id:
        return {'is_valid': False, 'status': 'error', 'message': '设备ID不能为空'}
    
    from sweeping.model.model_parameters import device_manager
    
    device_status = device_manager.get_device_status(device_id)
    if device_status != "在线":
        return {
            'is_valid': False, 
            'status': 'error', 
            'message': f'设备 {device_id} 当前离线，无法修改参数'
        }
    
    return {'is_valid': True}

def _check_parameter_dependencies(parameter, value):
    # 定义参数依赖规则
    dependency_rules = {
        'speed_limit': {
            'depends_on': ['max_acceleration'],
            'validation': lambda speed, max_acc: float(speed) <= float(max_acc) * 10
        },
        'battery_threshold': {
            'depends_on': ['min_operating_voltage'],
            'validation': lambda threshold, min_voltage: float(threshold) >= float(min_voltage)
        }
    }
    
    if parameter.code in dependency_rules:
        rule = dependency_rules[parameter.code]
        
        # 获取依赖参数的当前值
        for dep_param_code in rule['depends_on']:
            try:
                dep_param = Parameter.objects.get(
                    code=dep_param_code, 
                    device_id=parameter.device_id,
                    device_type=parameter.device_type
                )
                
                # 执行依赖校验
                if not rule['validation'](value, dep_param.value):
                    return {
                        'is_valid': False, 
                        'status': 'error', 
                        'message': f'参数值与依赖参数 {dep_param_code} 不兼容'
                    }
            except Parameter.DoesNotExist:
                return {
                    'is_valid': False, 
                    'status': 'error', 
                    'message': f'依赖参数 {dep_param_code} 不存在'
                }
    
    return {'is_valid': True}

def _device_specific_validation(parameter, value, device_id):
    device_type = parameter.device_type
    
    # 清扫车特定校验
    if device_type == 'vehicle':
        if parameter.code == 'brush_speed' and float(value) > 3000:
            return {
                'is_valid': False, 
                'status': 'error', 
                'message': '清扫车刷子转速不能超过3000转/分钟'
            }
    
    # 无人机特定校验
    elif device_type == 'uav':
        if parameter.code == 'flight_height' and float(value) > 120:
            return {
                'is_valid': False, 
                'status': 'error', 
                'message': '无人机飞行高度不能超过120米（法规限制）'
            }
    
    # 清洁船特定校验
    elif device_type == 'ship':
        if parameter.code == 'pump_pressure' and float(value) > 50:
            return {
                'is_valid': False, 
                'status': 'error', 
                'message': '清洁船水泵压力不能超过50bar'
            }
    
    return {'is_valid': True}

@login_required
def safe_edit_parameter(request, parameter_id):
    parameter = Parameter.objects.get(id=parameter_id)
    
    if request.method == 'POST':
        # 检查设备连接状态
        device_check = _check_device_connection_for_parameter(parameter.device_id)
        if not device_check['is_valid']:
            messages.error(request, device_check['message'])
            return render(request, 'edit_parameter.html', {
                'parameter': parameter,
                'device_offline': True
            })
        
        # 执行完整的参数校验
        new_value = request.POST.get('value')
        validation_result = validate_parameter_value(request)
        
        if validation_result.get('status') == 'success':
            # 记录标定历史并更新参数
            old_value = parameter.value
            parameter.value = new_value
            parameter.name = request.POST.get('name')
            parameter.code = request.POST.get('code')
            parameter.unit = request.POST.get('unit')
            parameter.description = request.POST.get('description')
            parameter.is_active = request.POST.get('is_active') == 'on'
            parameter.device_id = request.POST.get('device_id')
            parameter.device_type = request.POST.get('device_type')
            parameter.save()
            
            # 创建历史记录
            ParameterHistory.objects.create(
                parameter=parameter,
                old_value=old_value,
                new_value=new_value,
                updated_by=request.user if request.user.is_authenticated else None
            )
            
            messages.success(request, '参数更新成功。')
            return redirect('calibration_management')
        else:
            messages.error(request, validation_result.get('message', '参数校验失败'))
    
    return render(request, 'edit_parameter.html', {'parameter': parameter})
