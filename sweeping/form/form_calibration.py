from django import forms
from sweeping.model.model_calibration import Parameter

DEVICE_TYPE_CHOICES = [
    ('vehicle', '清扫车'),
    ('ship', '清洁船'),
    ('uav', '无人机'),
]

class ParameterForm(forms.ModelForm):
    device_type = forms.ChoiceField(choices=DEVICE_TYPE_CHOICES, label='设备类型')

    class Meta:
        model = Parameter
        fields = '__all__'
        labels = {
            'code': '类型',
            'description': '备注',
            'device_id': '设备ID'
        }
        widgets = {
            'device_id': forms.NumberInput(attrs={'class': 'form-control'})
        }