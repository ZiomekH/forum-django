from django.conf.urls.defaults import *
from django.conf import settings
from django.views.generic import *
from DFor.views import *

urlpatterns = patterns('',
    url(r'^zaloguj/$', 'django.contrib.auth.views.login', {'template_name': 'zaloguj.html'}),
    url(r'^wyloguj/$', widokWyloguj),
    
    url(r'^$', widokFora),
    url(r'^nowytemat/(?P<id>\d+)/$', widokNowyTemat),
    url(r'^temat/(?P<id>\d+)/$', widokTemat),
    url(r'^temat/(?P<id>\d+)/odpowiedz/$', widokOdpowiedz),
    
    url(r'^uzytkownicy/$', widokUzytkownicy),
    url(r'^uzytkownik/(?P<id>\d+)/$', widokUzytkownik),
    url(r'^profil/$', widokProfil),
    
    url(r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT})
)