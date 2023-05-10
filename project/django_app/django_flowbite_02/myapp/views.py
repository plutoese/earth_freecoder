from django.shortcuts import render

from .models import App

# Create your views here.
def index(request):
    return render(request, "index.html", {})


def app_list(request):
    app_list = App.objects.all()
    context = {
        "app_list": app_list,
    }
    return render(request, "app_list.html", context)