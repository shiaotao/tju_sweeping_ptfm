from django import forms
from .models import Vehicle
from .models import Parameter

class VehicleForm(forms.ModelForm):
    class Meta:
        model = Vehicle
        fields = '__all__'

# class ScheduleForm(forms.ModelForm):
#     class Meta:
#         model = Schedule
#         fields = ['vehicle', 'route_file_url', 'route_name']

class ParameterForm(forms.ModelForm):
    class Meta:
        model = Parameter
        fields = '__all__'