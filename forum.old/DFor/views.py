from django.http import HttpResponse
from django.http import HttpResponseRedirect
from django.shortcuts import render_to_response
from django.core.context_processors import csrf
from django.contrib.auth import authenticate, login, logout

from models import *
from forms import *

def widokFora(request):
    czyZalogowany = request.user.is_authenticated();
    uzytkownik = '';
    if (czyZalogowany):
	uzytkownik = Uzytkownik.objects.get(id=request.user.id)
    return render_to_response("fora.html", {'fora': Forum.objects.all(), 'czyZalogowany': czyZalogowany, 'uzytkownik': uzytkownik})

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

    
def widok_wyloguj(request):
    logout(request)
    return HttpResponseRedirect('/dfor')
    
def widok(request):
    zmienna = 'cos';
    return render_to_response("widok.html", {'request':request})