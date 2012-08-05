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
    
    
def zapiszAvatar(plik, nazwa):  
    with open(nazwa, 'wb+') as destination:
        for chunk in plik.chunks():
            destination.write(chunk)
    
    
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
      return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
    return render_to_response("uzytkownicy.html", {'uzytkownicy': Uzytkownik.objects.all(), 'czyZalogowany': czyZalogowany, 'uzytkownik': uzytkownik})

    
def widokUzytkownik(request, id):
    czyZalogowany = sprZalogowania(request)
    uzytkownik = sprUzytkownika(request, czyZalogowany)
    if (czyZalogowany == False):
      return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
    return render_to_response("uzytkownik.html", {'uzytk': Uzytkownik.objects.get(id=id), 'media': settings.MEDIA_URL, 'czyZalogowany': czyZalogowany, 'uzytkownik': uzytkownik})

    
def widokPostyUzytkownika(request, id):
    czyZalogowany = sprZalogowania(request)
    uzytkownik = sprUzytkownika(request, czyZalogowany)
    return render_to_response("posty.html", {'posty': Post.objects.filter(autor=id).order_by('-data_modyfikacji'), 'media': settings.MEDIA_URL, 'czyZalogowany': czyZalogowany, 'uzytkownik': uzytkownik})
    
    
def widokProfil(request):
    czyZalogowany = sprZalogowania(request)
    uzytkownik = sprUzytkownika(request, czyZalogowany)
    if (czyZalogowany == False):
      return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
    dane = {}
    dane.update(csrf(request))
    if request.method == "POST":
	formGlowne = formularzProfilGlowne(request.POST, instance=uzytkownik.uzytkownik)
	formDodatkowe = formularzProfilDodatkowe(request.POST, instance=uzytkownik)
	if formGlowne.is_valid() and formDodatkowe.is_valid():
	    formGlowne.save()
	    if(request.FILES):
		import os.path
		plik = request.FILES['avatar']
		nazwa = 'avatars/' + str(uzytkownik.id) + os.path.splitext(plik.name)[1].lower()
		zapiszAvatar(plik, settings.MEDIA_ROOT + nazwa)
		profil = formDodatkowe.save(commit=False)
		profil.avatar = nazwa
		profil.save()
		formDodatkowe.save_m2m()
	    formDodatkowe.save()
	    return HttpResponseRedirect('/dfor/uzytkownik/' + str(uzytkownik.id))
    else:
	formGlowne = formularzProfilGlowne(instance=uzytkownik.uzytkownik)
	formDodatkowe = formularzProfilDodatkowe(instance=uzytkownik)
	
    dane['formGlowne'] = formGlowne
    dane['formDodatkowe'] = formDodatkowe
    dane['czyZalogowany'] = czyZalogowany
    dane['uzytkownik'] = uzytkownik
    
    return render_to_response('profil.html', dane)


def widokRejestruj(request):
    czyZalogowany = sprZalogowania(request)
    uzytkownik = sprUzytkownika(request, czyZalogowany)
    if (czyZalogowany):
      return HttpResponseRedirect('/dfor/')
    dane = {}
    dane.update(csrf(request))
    if request.method == "POST":
	formGlowne = formularzRejestrujGlowne(request.POST)	
	formDodatkowe = formularzProfilDodatkowe(request.POST)
	if formGlowne.is_valid() and formDodatkowe.is_valid(): 
	    glowne = formGlowne.save()
	    glowne.set_password(glowne.password)
	    glowne.save()
	    formDodatkowe = formularzProfilDodatkowe(request.POST, instance=Uzytkownik.objects.get(id=glowne.id))
	    if(request.FILES):
		import os.path
		plik = request.FILES['avatar']
		nazwa = 'avatars/' + str(glowne.id) + os.path.splitext(plik.name)[1].lower()
		zapiszAvatar(plik, settings.MEDIA_ROOT + nazwa)
		profil = formDodatkowe.save(commit=False)
		profil.avatar = nazwa
		profil.save()
		formDodatkowe.save_m2m()
	    formDodatkowe.save()
	    
	    return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
    else:
	formGlowne = formularzRejestrujGlowne()
	formDodatkowe = formularzProfilDodatkowe()
	
    dane['formGlowne'] = formGlowne
    dane['formDodatkowe'] = formDodatkowe
    dane['czyZalogowany'] = czyZalogowany
    #dane['uzytkownik'] = uzytkownik
    
    return render_to_response('rejestruj.html', dane)


def widokOdpowiedz(request, id):
    czyZalogowany = sprZalogowania(request)
    uzytkownik = sprUzytkownika(request, czyZalogowany)
    if (czyZalogowany == False):
      return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
    dane = {}
    dane.update(csrf(request))
    if request.method == "POST":
	formPost = formularzPost(request.POST)
	post = formPost.save(commit=False)
	post.autor = uzytkownik
	post.save()
	formPost.save_m2m()
	temat = Temat.objects.get(id=id)
	temat.posty.add(post)
	temat.save()
	return HttpResponseRedirect('/dfor/temat/' + id)
    else:
	formPost = formularzPost()
	
    dane['formPost'] = formPost
    dane['zadanie'] = 'odpowiedz'
    dane['temat'] = Temat.objects.get(id=id)
    dane['czyZalogowany'] = czyZalogowany
    dane['uzytkownik'] = uzytkownik
	
    return render_to_response('formularz_post.html', dane)


def widokNowyTemat(request, id):
    czyZalogowany = sprZalogowania(request)
    uzytkownik = sprUzytkownika(request, czyZalogowany)
    if (czyZalogowany == False):
      return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
    dane = {}
    dane.update(csrf(request))
    if request.method == "POST":
	formPost = formularzPost(request.POST)
	formTemat = formularzTemat(request.POST)
	post = formPost.save(commit=False)
	post.autor = uzytkownik
	post.save()
	temat = formTemat.save(commit=False)
	temat.save()
	temat.posty.add(post)
	forum = Forum.objects.get(id=id)
	forum.tematy.add(temat)
	forum.save()
	formPost.save_m2m()
	formTemat.save_m2m()
	return HttpResponseRedirect('/dfor/temat/' + str(temat.id))
    else:
	formPost = formularzPost()
	formTemat = formularzTemat()
	
    dane['formPost'] = formPost
    dane['formTemat'] = formTemat
    dane['zadanie'] = 'nowy_temat'
    dane['forum'] = Forum.objects.get(id=id)
    dane['czyZalogowany'] = czyZalogowany
    dane['uzytkownik'] = uzytkownik
	
    return render_to_response('formularz_post.html', dane)


def widokEdytujPost(request, id):
    czyZalogowany = sprZalogowania(request)
    uzytkownik = sprUzytkownika(request, czyZalogowany)
    if (czyZalogowany == False):
	return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
	
    post = Post.objects.get(id=id)
    if(post.autor != uzytkownik and not uzytkownik.uzytkownik.is_staff):
	return HttpResponseRedirect('/dfor/')
	
    dane = {}
    dane.update(csrf(request))
    if request.method == "POST":
	formPost = formularzPost(request.POST, instance=Post.objects.get(id=id))
	formPost.save()
	return HttpResponseRedirect('/dfor/temat/' + str(Temat.objects.filter(posty=post)[0].id))
    else:
	formPost = formularzPost(instance=Post.objects.get(id=id))
	
    dane['formPost'] = formPost
    dane['zadanie'] = 'edytuj'
    dane['temat'] = Temat.objects.filter(posty=post)[0]
    dane['czyZalogowany'] = czyZalogowany
    dane['uzytkownik'] = uzytkownik
	
    return render_to_response('formularz_post.html', dane)


def widokUsunPost(request, id):
    czyZalogowany = sprZalogowania(request)
    uzytkownik = sprUzytkownika(request, czyZalogowany)
    if (czyZalogowany == False):
	return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
	
    post = Post.objects.get(id=id)
    if(post.autor != uzytkownik and not uzytkownik.uzytkownik.is_staff):
	return HttpResponseRedirect('/dfor/')

    temat = Temat.objects.filter(posty=post)[0]
    if (temat.posty.count() == 1):
	temat.delete()
	post.delete()
	return HttpResponseRedirect('/dfor/')	
    
    post.delete()
    return HttpResponseRedirect('/dfor/')


def widokWyloguj(request):
    logout(request)
    return HttpResponseRedirect('/dfor')
