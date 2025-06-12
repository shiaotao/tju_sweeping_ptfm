from django.shortcuts import render, redirect
from django.contrib import messages
from django.views.decorators.csrf import csrf_exempt
from sweeping.model.model_parameter import Parameter
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
import json

@login_required
def calibration_management(request):
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
        return redirect('calibration_management')
    
    from sweeping.model.model_vehicle import Vehicle
    parameters = Parameter.objects.all()
    vehicles = Vehicle.objects.all()
    return render(request, 'calibration_management.html', {'parameters': parameters, 'vehicles': vehicles})

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
        return redirect('calibration_management')
    
    return render(request, 'add_parameter.html')

@login_required
def edit_parameter(request, parameter_id):
    parameter = Parameter.objects.get(id=parameter_id)
    if request.method == 'POST':
        parameter.name = request.POST.get('name')
        parameter.code = request.POST.get('code')
        parameter.value = request.POST.get('value')
        parameter.unit = request.POST.get('unit')
        parameter.description = request.POST.get('description')
        parameter.is_active = request.POST.get('is_active') == 'on'
        parameter.device_id = request.POST.get('device_id')
        parameter.device_type = request.POST.get('device_type')
        parameter.save()
        messages.success(request, '参数更新成功。')
        return redirect('calibration_management')
    
    return render(request, 'edit_parameter.html', {'parameter': parameter})

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