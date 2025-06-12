from rest_framework import serializers
from sweeping.model.model_vehicle import Vehicle
class VehicleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vehicle
        fields = '__all__'