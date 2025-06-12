from django.contrib.auth import authenticate, login,logout
from django.contrib import messages
from django.shortcuts import render, redirect
from sweeping.models import User
# 用户管理
def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('dashboard')
        else:
            messages.error(request, '用户名或密码错误，请重试。')
    return render(request, 'login.html')
def logout_view(request):
    logout(request)
    return redirect('login')  # 重定向到登录页面
def reset_password(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        new_password = request.POST.get('new_password')
        try:
            user = User.objects.get(username=username)
            user.set_password(new_password)
            user.save()
            messages.success(request, '密码重置成功，请使用新密码登录。')
        except User.DoesNotExist:
            messages.error(request, '用户不存在，请重试。')
    return render(request, 'reset_password.html')