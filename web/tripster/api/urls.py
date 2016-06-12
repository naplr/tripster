from django.conf.urls import url, include
import api.views as views

urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^v1/add-post/$', views.add_post, name='add_post'),
    url(r'^v1/get-post/$', views.get_post, name='get_post'),
    url(r'^v1/check-location/$', views.check_location, name='check_location')
]
