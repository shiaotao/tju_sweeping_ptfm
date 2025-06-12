from rest_framework import serializers
from sweeping.model.model_user import User

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'