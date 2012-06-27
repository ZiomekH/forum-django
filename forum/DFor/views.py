from django.http import HttpResponse
from django.http import HttpResponseRedirect
from django.shortcuts import render_to_response
from django.core.context_processors import csrf

from models import *
from forms import * 

def widokOdpowiedz(request, pk):
  data = {}
  data.update(csrf(request))
  if request.method == "POST":
    form = PostForm(request.POST)
    if form.is_valid():
      #dodawanie do bazy
      return render_to_response('.', data)
  else:
    form = PostForm()

  data['form'] = form  
  return render_to_response('odpowiedz.html', data)