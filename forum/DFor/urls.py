from django.conf.urls.defaults import *
from django.views.generic import *
from DFor.views import *

urlpatterns = patterns('',
    url(r'^zaloguj/$', 'django.contrib.auth.views.login', {'template_name': 'zaloguj.html'}),
    url(r'^wyloguj/$', widokWyloguj),
    url(r'^$', widokFora),
    url(r'^uzytkownicy/$', widokUzytkownicy),
    
    url(r'^(?P<pk>\d+)$', DetailView.as_view(model=Temat, template_name="tematy.html"))
)