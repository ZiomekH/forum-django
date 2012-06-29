from django.conf.urls.defaults import *
from django.views.generic import *
from DFor.views import *

urlpatterns = patterns('',
    url(r'^zaloguj/$', 'django.contrib.auth.views.login', {'template_name': 'zaloguj.html'}),
    url(r'^wyloguj/$', widok_wyloguj),
    url(r'^widok/$', widok),
    url(r'^$', widokFora),
    
    url(r'^(?P<pk>\d+)$', DetailView.as_view(model=Temat, template_name="tematy.html"))
)