import json
import datetime
# import paho.mqtt.client as mqtt
from .mqtt_client import initialize_mqtt_client
from django.shortcuts import render, redirect
# from django.contrib.auth import authenticate, login
from django.contrib import messages
from django.http import JsonResponse, HttpResponse
from django.views.decorators.csrf import csrf_exempt
from .models import User
from .model.model_vehicle import Vehicle
from .form.form_vehicle import VehicleForm
from django.db.models import Count
from django.utils import timezone
# from django.contrib.auth import logout
import uuid

# 初始化MQTT客户端
mqtt_client = None


# 用户管理
# def login_view(request):
#     if request.method == 'POST':
#         username = request.POST.get('username')
#         password = request.POST.get('password')
#         user = authenticate(request, username=username, password=password)
#         if user is not None:
#             login(request, user)
#             return redirect('dashboard')
#         else:
#             messages.error(request, '用户名或密码错误，请重试。')
#     return render(request, 'login.html')
# def logout_view(request):
#     logout(request)
#     return redirect('login')  # 重定向到登录页面
# def reset_password(request):
#     if request.method == 'POST':
#         username = request.POST.get('username')
#         new_password = request.POST.get('new_password')
#         try:
#             user = User.objects.get(username=username)
#             user.set_password(new_password)
#             user.save()
#             messages.success(request, '密码重置成功，请使用新密码登录。')
#         except User.DoesNotExist:
#             messages.error(request, '用户不存在，请重试。')
#     return render(request, 'reset_password.html')

# # 车辆管理
# def vehicle_management(request):
#     if request.method == 'POST':
#         form = VehicleForm(request.POST)
#         if form.is_valid():
#             form.save()
#             messages.success(request, '车辆信息添加成功。')
#             return redirect('vehicle_management')
#     else:
#         form = VehicleForm()
#     vehicles = Vehicle.objects.all()
#     return render(request, 'vehicle_management.html', {'form': form, 'vehicles': vehicles})
# def add_vehicle(request):
#     print("add_vehicle called")
#     if request.method == 'POST':
#         print(request.method)
#         form = VehicleForm(request.POST)
#         print(form.is_valid())
#         if form.is_valid():
#             form.save()
#             print("saved")
#             messages.success(request, '车辆信息添加成功。')
#             return redirect('vehicle_management')
#         else:
#             # 打印表单错误信息
#             print(form.errors)
#     else:
#         form = VehicleForm()
#     return render(request, 'add_vehicle.html', {'form': form})
# def edit_vehicle(request, vehicle_id):
#     vehicle = Vehicle.objects.get(id=vehicle_id)
#     if request.method == 'POST':
#         form = VehicleForm(request.POST, instance=vehicle)
#         if form.is_valid():
#             form.save()
#             messages.success(request, '车辆信息更新成功。')
#             return redirect('vehicle_management')
#     else:
#         form = VehicleForm(instance=vehicle)
#     return render(request, 'edit_vehicle.html', {'form': form, 'vehicle': vehicle})

# def delete_vehicle(request, vehicle_id):
#     vehicle = Vehicle.objects.get(id=vehicle_id)
#     vehicle.delete()
#     messages.success(request, '车辆信息删除成功。')
#     return redirect('vehicle_management')

# 远程调度
# def schedule_management(request):
#     if request.method == 'POST':
#         form = ScheduleForm(request.POST)
#         if form.is_valid():
#             schedule = form.save(commit=False)
#             schedule.schedule_id = uuid.uuid4()
#             schedule.timestamp = timezone.now()
#             schedule.save()
#             # 发送调度指令到车端
#             message = {
#                 'schedule_id': str(schedule.schedule_id),
#                 'timestamp': schedule.timestamp.isoformat(),
#                 'route_file_url': schedule.route_file_url,
#                 'route_name': schedule.route_name
#             }
#             mqtt_client.publish(f"vehicle/{schedule.vehicle.vehicle_number}/schedule", json.dumps(message))
#             messages.success(request, '调度指令发送成功。')
#             return redirect('schedule_management')
#     else:
#         form = ScheduleForm()
#     schedules = Schedule.objects.all().select_related('vehicle')
#     vehicles = Vehicle.objects.all()
#     return render(request, 'schedule_management.html', {'form': form, 'schedules': schedules, 'vehicles': vehicles})

# 实时监控
# def real_time_monitoring(request):
#     # 假设从MQTT接收的数据存储在session中，这里只是一个示例
#     vehicle_data = request.session.get('vehicle_data', [])
#     return render(request, 'real_time_monitoring.html', {'vehicle_data': vehicle_data})
def real_time_monitoring(request):
    # global mqtt_client
    # if mqtt_client is None:
    #     mqtt_client = initialize_mqtt_client()
    # 假设这是你的车辆数据
    vehicle_data = [
        {
            'vehicle_number': 'Vehicle 1',
            'longitude': 116.397428,
            'latitude': 39.90923,
            'battery': 80
        },
        {
            'vehicle_number': 'Vehicle 2',
            'longitude': 116.407428,
            'latitude': 39.91923,
            'battery': 70
        }
    ]
    # 将车辆数据转换为 JSON 格式
    json_vehicle_data = json.dumps(vehicle_data)
    return render(request, 'real_time_monitoring.html', {'vehicle_data': json_vehicle_data})
# 数据管理与分析
# def data_analysis(request):
#     start_date = request.GET.get('start_date')
#     end_date = request.GET.get('end_date')
#     if start_date and end_date:
#         start_date = datetime.datetime.strptime(start_date, '%Y-%m-%d').date()
#         end_date = datetime.datetime.strptime(end_date, '%Y-%m-%d').date()
#         operations = Operation.objects.filter(operation_date__range=[start_date, end_date])
#     else:
#         current_month = timezone.now().month
#         operations = Operation.objects.filter(operation_date__month=current_month)
    
#     vehicle_operations = operations.values('vehicle__vehicle_number').annotate(
#         total_days=Count('operation_date', distinct=True),
#         total_operations=Count('id')
#     )
#     return render(request, 'data_analysis.html', {'vehicle_operations': vehicle_operations})
def dashboard(request):
    return render(request, 'dashboard.html')  # 确保有对应的模板文件 