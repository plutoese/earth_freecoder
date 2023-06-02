from django.urls import path

from .views import index, app_list

urlpatterns = [
    path('', index, name='index'),
    path('apps', app_list, name='apps')
]