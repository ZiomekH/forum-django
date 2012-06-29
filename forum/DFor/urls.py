from django.conf.urls.defaults import *
from django.views.generic import *
from DFor.views import *

urlpatterns = patterns('',
    url(r'^login/$', 'django.contrib.auth.views.login', {'template_name': 'login.html'}),
    url(r'^widok/$', my_view),
    url(r'^wyloguj/$', widok_wyloguj),
    
    url(r'^$', ListView.as_view(queryset=Forum.objects.all(), template_name="fora.html")),
    url(r'^(?P<pk>\d+)/odpowiedz$', widokOdpowiedz),
    url(r'^(?P<pk>\d+)$', DetailView.as_view(model=Temat, template_name="tematy.html"))
)