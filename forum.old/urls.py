from django.conf.urls.defaults import patterns, include, url

from django.contrib import admin
import DFor.urls

admin.autodiscover()

urlpatterns = patterns('',
    url(r'^dfor/', include(DFor.urls)),
    url(r'^admin/', include(admin.site.urls))
)
