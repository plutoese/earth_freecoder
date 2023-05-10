import datetime

from django.db import models

# Create your models here.
class App(models.Model):
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=50)
    content = models.TextField()
    category = models.CharField(max_length=100, default="app")
    labels = models.TextField()
    link = models.TextField()
    date_modified = models.DateTimeField(auto_now=True)
    date_published = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title