from django import forms
from sweeping.model.model_vehicle import Vehicle

class VehicleForm(forms.ModelForm):
    class Meta:
        model = Vehicle
        fields = '__all__'