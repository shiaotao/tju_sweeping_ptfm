from django.urls import path
from sweeping.view.user_manage import login_view, reset_password, logout_view
from sweeping.view.vehicle_manage import vehicle_management, add_vehicle, edit_vehicle, delete_vehicle,get_vehicle_data
from sweeping.view.dashboard import dashboard
from sweeping.view.calibration_manage import calibration_management, add_parameter, edit_parameter, delete_parameter, batch_delete_parameters
from sweeping.view.calibration_manage import get_parameter_data as get_param_data   # 处理同名函数
from sweeping.view.dashboard import dashboard
from sweeping.view.remote_calib import *
from sweeping.view.param_registory import *
from sweeping.view.fault_diagnose import *
from sweeping.view.param_calibration import *
from sweeping.view.device_connection import *

urlpatterns = [
    # 用户管理
    path('login/', login_view, name='login'),
    path('reset_password/', reset_password, name='reset_password'),
    path('logout/', logout_view, name='logout'),
    path('', login_view, name='login'),

    # 仪表盘
    path('dashboard/', dashboard, name='dashboard'),
    
    # 车辆管理
    path('vehicle_management/', vehicle_management, name='vehicle_management'),# 列表查询
    path('add_vehicle/', add_vehicle, name='add_vehicle'),# 新增
    path('edit_vehicle/<int:vehicle_id>/', edit_vehicle, name='edit_vehicle'),# 修改
    path('delete_vehicle/<int:vehicle_id>/', delete_vehicle, name='delete_vehicle'),# 删除
    path('get-vehicle-data/<int:vehicle_id>/', get_vehicle_data, name='get_vehicle_data'),
    
    # 远程标定
    path('remote-calibrate-param/', remote_calib, name='remote_calib'),

    # 远程标定 - 校准参数管理
    path('remote-calibrate-param/calibration_management/', calibration_management, name='calibration_management'),
    path('add_parameter/', add_parameter, name='add_parameter'),
    path('edit_parameter/<int:parameter_id>/', edit_parameter, name='edit_parameter'),
    path('delete_parameter/<int:parameter_id>/', delete_parameter, name='delete_parameter'),
    path('get_parameter_data/<int:parameter_id>/', get_param_data, name='get_param_data'),
    path('batch_delete_parameters/', batch_delete_parameters, name='batch_delete_parameters'),

    # 远程标定 - 参数标定
    path('parameter_calibration/', param_calibration, name='param_calibration'),
    path('calib_edit_parameter/<int:parameter_id>/', calib_edit_parameter, name='calib_edit_parameter'),
    path('safe_edit_parameter/<int:parameter_id>/', safe_edit_parameter, name='safe_edit_parameter'),
    path('validate_parameter_value/', validate_parameter_value, name='validate_parameter_value'),
    # 远程标定 - 设备连接状态管理
    path('device_connection_status/', device_connection_status, name='device_connection_status'),
    path('device/<int:device_id>/connection/', check_device_connection, name='check_device_connection'),
    path('add_device_to_monitor/', add_device_to_monitor, name='add_device_to_monitor'),

    # 远程标定 - 历史记录
    path('remote-calibrate-param/registory/', param_registory, name='rcp_regMain'),
    path('remote-calibrate-param/registory/origin', prmReg_Origin, name='rcp_regOrigin'),
    path('remote-calibrate-param/registory/?event=<int:prm_id>', prmReg_viewDtl, name='rcp_regDetail'),
    path('remote-calibrate-param/add-record/', prmReg_addRec, name='rcp_addRecord'),
    path('remote-calibrate-param/update_remark/', prmReg_updateRmk, name='rcp_updateRmk'),
    path('remote-calibrate-param/view-detail/', param_viewDtl, name='rcp_viewDetail'),
    path('get-parameter-data/<int:prm_id>/', get_parameter_data, name='get_parameter_data'),

    # 故障诊断
    path('temporal-experiment-page/please-remove/', temporal_experi, name='temporary')
]