from django.db import models

# Create your models here.
class Post(models.Model):
    id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=256)
    caption = models.CharField(max_length=1024, blank=True, null=True)
    image = models.ImageField(upload_to='images/', default='images/None/how-is-this-here.jpg', blank=True, null=True)
    image_date = models.DateTimeField(blank=True, null=True)
    latitude = models.FloatField()
    longitude = models.FloatField()
