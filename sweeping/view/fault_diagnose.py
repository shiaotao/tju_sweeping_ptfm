from django.shortcuts import render, redirect

def temporal_experi(request):
    return render(request, 'experimentalPage.html')