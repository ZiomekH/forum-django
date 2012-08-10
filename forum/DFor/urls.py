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
    
    url(r'^post/edytuj/(?P<id>\d+)/$', widokEdytujPost),
    url(r'^post/usun/(?P<id>\d+)/$', widokUsunPost),
    
    url(r'^uzytkownicy/$', widokUzytkownicy),
    url(r'^uzytkownik/(?P<id>\d+)/$', widokUzytkownik),
    url(r'^uzytkownik/posty/(?P<id>\d+)/$', widokPostyUzytkownika),
    url(r'^profil/$', widokProfil),
    url(r'^profil/zmianahasla/$', widokZmianaHasla),
    url(r'^zarejestruj/$', widokRejestruj),
    
    url(r'^szukaj/$', widokSzukaj),
    
    url(r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT})
)