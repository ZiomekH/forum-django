from django.conf.urls.defaults import *
from django.views.generic import *
from DFor.views import *

urlpatterns = patterns('',
  url(r'^$', ListView.as_view(queryset=Forum.objects.all(), template_name="fora.html")),
  url(r'^(?P<pk>\d+)/odpowiedz$', widokOdpowiedz),
  url(r'^(?P<pk>\d+)$', DetailView.as_view(model=Temat, template_name="tematy.html"))
)