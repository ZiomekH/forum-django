from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

import DFor.urls

urlpatterns = patterns('',
    url(r'^admin/', include(admin.site.urls)),
    url(r'^dfor/', include(DFor.urls))
)
