from django.shortcuts import render, redirect
def dashboard(request):
    return render(request, 'dashboard.html')  # 确保有对应的模板文件 