from django.contrib import admin
from .models import User
from .model.model_vehicle import Vehicle
admin.site.register(User)
admin.site.register(Vehicle)
# admin.site.register(Schedule)
# admin.site.register(Operation)