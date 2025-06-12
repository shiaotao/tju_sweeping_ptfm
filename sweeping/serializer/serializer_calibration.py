from rest_framework import serializers
from sweeping.model.model_calibration import Parameter

class ParameterSerializer(serializers.ModelSerializer):
    device_type_display = serializers.SerializerMethodField()

    class Meta:
        model = Parameter
        fields = ['id', 'name', 'code', 'value', 'unit', 'description', 'is_active', 'device_id', 'device_type', 'device_type_display']

    def get_device_type_display(self, obj):
        return obj.get_device_type_display()