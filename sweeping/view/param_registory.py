import json
from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from sweeping.model.model_parameter import Parameter
from sweeping.forms import ParameterForm
from django.http import JsonResponse

@login_required
def param_registory(request):
    parameters = Parameter.objects.all().order_by('name', '-update_at')
    param_list = []
    for p in parameters:
        param_list.append({
            'id': p.id,
            'name': p.name,
            'code': p.code,
            'nst_display': p.get_nst_display() if hasattr(p, 'get_nst_display') else p.nst,
            'value': p.value,
            'unit': p.unit,
            'state_display': p.get_state_display() if hasattr(p, 'get_state_display') else p.state,
            'created_at': p.created_at.strftime('%Y-%m-%d %H:%M:%S') if hasattr(p, 'created_at') and p.created_at else "",
            'update_at': p.update_at.strftime('%Y-%m-%d %H:%M:%S') if hasattr(p, 'update_at') and p.update_at else "",
            'oid': p.oid,
            'user': p.user,
            'description': p.description,
            'device_id': getattr(p, 'device_id', ''),
            'device_type': getattr(p, 'device_type', ''),
        })
    return render(request, 'param_registory.html', {
        'parameters_json': json.dumps(param_list, ensure_ascii=False)
    })

@login_required
def prmReg_Origin(request):
    # About to Abort
    return render(request, 'ExperimentalPage.html')

@login_required
def prmReg_addRec(request):
    print("prmReg_addRec called.")
    form = ParameterForm(request.POST)
    print(form.is_valid())
    if form.is_valid():
        form.save()
        print("Param added.")
        messages.success(request, '记录信息添加成功。')
        return redirect('rcp_regMain')
    else:
        print(form.errors)

@login_required
def prmReg_updateRmk(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            prm_id = data.get('prm_id')
            remark = data.get('param_Users_Remark')
            parameter = Parameter.objects.get(id=prm_id)
            parameter.description = remark
            parameter.save()
            return JsonResponse({'success': True})
        except Parameter.DoesNotExist:
            return JsonResponse({'success': False, 'error': '参数不存在'})
        except Exception as e:
            return JsonResponse({'success': False, 'error': str(e)})
    return JsonResponse({'success': False, 'error': '仅支持POST'})

@login_required
def prmReg_viewDtl(request, prm_id):
    parameter = Parameter.objects.get(id=prm_id)
    if request.method == 'POST':
        form = ParameterForm(request.POST, instance=parameter)
        if form.is_valid():
            
            return redirect('rcp_regMain')
    else:
        form = ParameterForm(instance=parameter)
    return render(request, 'param_record_detail.html', {'form': form, 'parameter': parameter})

@login_required
def param_viewDtl(request):
    # About to Abort
    prm_id = request.GET.get('event')
    return render(request, 'param_record_detail.html', {'prm_id': prm_id})

@login_required
def get_parameter_data(request, prm_id):
    param_PrevValue = None
    param_NextValue = None
    try:
        parameter = Parameter.objects.get(id=prm_id)
        
        if parameter.oid != -1:
            try:
                param_PrevValue = Parameter.objects.get(id=parameter.oid).value
            except Parameter.DoesNotExist:
                param_PrevValue = None
        if parameter.cid != -1:
            try:
                param_NextValue = Parameter.objects.get(id=parameter.cid).value
            except Parameter.DoesNotExist:
                param_NextValue = None
        
        data = {
            'param_id': parameter.id,
            'param_Name': parameter.name,
            'param_DataType': parameter.code,
            'param_Nst': parameter.get_nst_display(),
            'param_Value': parameter.value,
            'param_ValUnit': parameter.unit,
            'param_OrgID': parameter.oid,
            'param_PrevValue': param_PrevValue,
            'param_ChaID': parameter.cid,
            'param_NextValue': param_NextValue,
            'param_State': parameter.get_state_display(),
            'param_Record_Time': parameter.created_at.strftime('%Y-%m-%d %H:%M:%S') if parameter.created_at else None,
            'param_Update_Time': parameter.update_at.strftime('%Y-%m-%d %H:%M:%S') if parameter.update_at else None,
            'param_Operator': str(parameter.user) if parameter.user else None,
            'param_DeviceID': parameter.device_id,
            'param_Device_Type': parameter.get_device_type_display(),
            'param_Users_Remark': parameter.description,
            'param_Is_Active': parameter.is_active
        }
        return JsonResponse(data)
    except Parameter.DoesNotExist:
        return JsonResponse({'error': 'Parameter not found'}, status=404)