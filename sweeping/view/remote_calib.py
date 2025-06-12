from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from sweeping.model.model_parameter import Parameter
from sweeping.forms import ParameterForm
from django.http import JsonResponse

@login_required
def remote_calib(request):
    return render(request, 'remote_calib.html')