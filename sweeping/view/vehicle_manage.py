from django.shortcuts import render, redirect
from django.contrib import messages
from django.views.decorators.csrf import csrf_exempt
from sweeping.model.model_vehicle import Vehicle
from sweeping.form.form_vehicle import VehicleForm
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
# 车辆管理
@login_required
def vehicle_management(request):
    if request.method == 'POST':
        form = VehicleForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, '车辆信息添加成功。')
            return redirect('vehicle_management')
    else:
        form = VehicleForm()
    vehicles = Vehicle.objects.all()
    return render(request, 'vehicle_management.html', {'form': form, 'vehicles': vehicles})
@login_required
def add_vehicle(request):
    print("add_vehicle called")
    if request.method == 'POST':
        print(request.method)
        form = VehicleForm(request.POST)
        print(form.is_valid())
        if form.is_valid():
            form.save()
            print("saved")
            messages.success(request, '车辆信息添加成功。')
            return redirect('vehicle_management')
        else:
            # 打印表单错误信息
            print(form.errors)
    else:
        form = VehicleForm()
    return render(request, 'add_vehicle.html', {'form': form})
@login_required
def edit_vehicle(request, vehicle_id):
    vehicle = Vehicle.objects.get(id=vehicle_id)
    if request.method == 'POST':
        form = VehicleForm(request.POST, instance=vehicle)
        if form.is_valid():
            form.save()
            messages.success(request, '车辆信息更新成功。')
            return redirect('vehicle_management')
    else:
        form = VehicleForm(instance=vehicle)
    return render(request, 'edit_vehicle.html', {'form': form, 'vehicle': vehicle})
@login_required
def delete_vehicle(request, vehicle_id):
    vehicle = Vehicle.objects.get(id=vehicle_id)
    vehicle.delete()
    messages.success(request, '车辆信息删除成功。')
    return redirect('vehicle_management')


@login_required
def get_vehicle_data(request, vehicle_id):
    try:
        vehicle = Vehicle.objects.get(id=vehicle_id)
        data = {
            'id': vehicle.id,
            'vehicle_number': vehicle.vehicle_number,
            'vin_code': vehicle.vin_code,
            'license_plate': vehicle.license_plate,
            'manufacturer': vehicle.manufacturer,
            'brand': vehicle.brand,
            'operation_date': vehicle.operation_date.strftime('%Y-%m-%d')
        }
        return JsonResponse(data)
    except Vehicle.DoesNotExist:
        return JsonResponse({'error': 'Vehicle not found'}, status=404)