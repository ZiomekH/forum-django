from django.http import HttpResponse
from django.http import HttpResponseRedirect
from django.shortcuts import render_to_response
from django.core.context_processors import csrf
from django.contrib.auth import authenticate, login, logout
from django.conf import settings

from models import *
from forms import *

def sprZalogowania(request):
    return request.user.is_authenticated();

def sprUzytkownika(request, czyZalogowany):
    if (czyZalogowany):
	return Uzytkownik.objects.get(id=request.user.id)
    return ''
    
def widokFora(request):
    czyZalogowany = sprZalogowania(request)
    uzytkownik = sprUzytkownika(request, czyZalogowany)
    return render_to_response("fora.html", {'fora': Forum.objects.all(), 'czyZalogowany': czyZalogowany, 'uzytkownik': uzytkownik})

def widokTemat(request, id):
    czyZalogowany = sprZalogowania(request)
    uzytkownik = sprUzytkownika(request, czyZalogowany)
    return render_to_response("temat.html", {'temat': Temat.objects.get(id=id), 'media': settings.MEDIA_URL, 'czyZalogowany': czyZalogowany, 'uzytkownik': uzytkownik})
    
def widokUzytkownicy(request):
    czyZalogowany = sprZalogowania(request)
    uzytkownik = sprUzytkownika(request, czyZalogowany)
    if (czyZalogowany == False):
      return HttpResponseRedirect('/dfor/zaloguj/?next=/dfor/uzytkownicy')
    return render_to_response("uzytkownicy.html", {'uzytkownicy': Uzytkownik.objects.all(), 'czyZalogowany': czyZalogowany, 'uzytkownik': uzytkownik})

def widokUzytkownik(request, id):
    czyZalogowany = sprZalogowania(request)
    uzytkownik = sprUzytkownika(request, czyZalogowany)
    if (czyZalogowany == False):
      return HttpResponseRedirect('/dfor/zaloguj/?next=/dfor/uzytkownik/' + id)
    return render_to_response("uzytkownik.html", {'uzytk': Uzytkownik.objects.get(id=id), 'media': settings.MEDIA_URL, 'czyZalogowany': czyZalogowany, 'uzytkownik': uzytkownik})

def widokProfil(request):
    czyZalogowany = sprZalogowania(request)
    uzytkownik = sprUzytkownika(request, czyZalogowany)
    if (czyZalogowany == False):
      return HttpResponseRedirect('/dfor/zaloguj/?next=/dfor/profil')
    dane = {}
    dane.update(csrf(request))
    if request.method == "POST":
	form = UzytkownikForm(request.POST, instance=uzytkownik)
	if form.is_valid():
	    form.save()
	return HttpResponseRedirect('/dfor')
    else:
	form = UzytkownikForm(instance=uzytkownik)
	
    dane['form'] = form
    dane['media'] = settings.MEDIA_URL
    dane['czyZalogowany'] = czyZalogowany
    dane['uzytkownik'] = uzytkownik
    
    return render_to_response('profil.html', dane)
    
def widokWyloguj(request):
    logout(request)
    return HttpResponseRedirect('/dfor')
    
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