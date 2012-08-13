# -*- encoding: utf-8 -*-

from django.http import HttpResponse
from django.http import HttpResponseRedirect
from django.shortcuts import render_to_response
from django.core.context_processors import csrf
from django.contrib.auth import authenticate, login, logout
from django.conf import settings
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

from models import *
from forms import *


def sprUzytkownika(request, czyZalogowany):
    if (czyZalogowany):
	return Uzytkownik.objects.get(id=request.user.id)
    return ''


def widokFor(request):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())  
    return render_to_response("lista_for.html", {'fora': Forum.objects.all(), 'uzytkownik': uzytkownik})


def widokForum(request, id):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated()) 
    
    podzial = Paginator(Temat.objects.filter(forum=id).order_by('-data_utworzenia'), 25)
    strona = request.GET.get('strona')
    try:
	tematy = podzial.page(strona)
    except PageNotAnInteger:
	tematy = podzial.page(1)
    except EmptyPage:
	tematy = podzial.page(podzial.num_pages)
    
    return render_to_response("lista_tematow.html", {'forum': Forum.objects.get(id=id), 'tematy': tematy, 'tytul': Forum.objects.get(id=id).nazwa, 'zadanie': 'forum', 'uzytkownik': uzytkownik})


def widokTemat(request, id):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    
    podzial = Paginator(Post.objects.filter(temat=id).order_by('data_utworzenia'), 10)
    strona = request.GET.get('strona')
    try:
	posty = podzial.page(strona)
    except PageNotAnInteger:
	posty = podzial.page(1)
    except EmptyPage:
	posty = podzial.page(podzial.num_pages)
	
    return render_to_response("lista_postow.html", {'posty': posty, 'tytul': Temat.objects.get(id=id).tytul, 'zadanie': 'lista_postow', 'media': settings.MEDIA_URL, 'uzytkownik': uzytkownik})


def widokPostyUzytkownika(request, id):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    
    podzial = Paginator(Post.objects.filter(autor=id).order_by('-data_modyfikacji'), 10)
    strona = request.GET.get('strona')
    try:
	posty = podzial.page(strona)
    except PageNotAnInteger:
	posty = podzial.page(1)
    except EmptyPage:
	posty = podzial.page(podzial.num_pages)
    
    return render_to_response("lista_postow.html", {'posty': posty, 'tytul': 'Posty użytkownika: ' + str(Uzytkownik.objects.get(id=id)), 'zadanie': 'posty_uzytkownika' ,'media': settings.MEDIA_URL, 'uzytkownik': uzytkownik})


def widokNowyTemat(request, id):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    if (not request.user.is_authenticated()):
      return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
    dane = {}
    dane.update(csrf(request))
    if request.method == "POST":
	formPost = formularzPost(request.POST)
	formTemat = formularzTemat(request.POST)
	if formPost.is_valid() and formTemat.is_valid():
	    temat = formTemat.save(commit=False)
	    temat.forum = Forum.objects.get(id=id)
	    temat.save()	    
	    post = formPost.save(commit=False)
	    post.autor = uzytkownik
	    post.temat = temat
	    post.save()
	    formPost.save_m2m()
	    formTemat.save_m2m()
	    
	    return HttpResponseRedirect('/dfor/temat/' + str(temat.id))
    else:
	formPost = formularzPost()
	formTemat = formularzTemat()
	
    dane['formPost'] = formPost
    dane['formTemat'] = formTemat
    dane['zadanie'] = 'nowy_temat'
    dane['tytul'] = Forum.objects.get(id=id).nazwa
    dane['uzytkownik'] = uzytkownik
	
    return render_to_response('formularz_postow.html', dane)


def widokOdpowiedz(request, id):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    if (not request.user.is_authenticated()):
      return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
    dane = {}
    dane.update(csrf(request))
    if request.method == "POST":
	formPost = formularzPost(request.POST)
	if formPost.is_valid():
	    post = formPost.save(commit=False)
	    post.autor = uzytkownik
	    post.temat = Temat.objects.get(id=id)
	    post.save()
	    formPost.save_m2m()
	    return HttpResponseRedirect('/dfor/temat/' + id + '?strona=9999999999999999')
    else:
	formPost = formularzPost()
	
    dane['formPost'] = formPost
    dane['zadanie'] = 'odpowiedz'
    dane['tytul'] = Temat.objects.get(id=id).tytul
    dane['uzytkownik'] = uzytkownik
	
    return render_to_response('formularz_postow.html', dane)


def widokEdytujPost(request, id):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    if (not request.user.is_authenticated()):
	return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
	
    post = Post.objects.get(id=id)
    if(post.autor != uzytkownik and not uzytkownik.uzytkownik.is_staff):
	return HttpResponseRedirect('/dfor/')
	
    dane = {}
    dane.update(csrf(request))
    if request.method == "POST":
	formPost = formularzPost(request.POST, instance=Post.objects.get(id=id))
	if formPost.is_valid():
	    formPost.save()
	    return HttpResponseRedirect('/dfor/temat/' + str(Post.objects.get(id=id).temat.id))
    else:
	formPost = formularzPost(instance=Post.objects.get(id=id))
	
    dane['formPost'] = formPost
    dane['zadanie'] = 'edytuj'
    dane['tytul'] = Post.objects.get(id=id).temat.tytul
    dane['uzytkownik'] = uzytkownik
	
    return render_to_response('formularz_postow.html', dane)


def widokUsunPost(request, id):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    if (not request.user.is_authenticated()):
	return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
	
    post = Post.objects.get(id=id)
    if(post.autor != uzytkownik and not uzytkownik.uzytkownik.is_staff):
	return HttpResponseRedirect('/dfor/')

    if (post.temat.iloscOdpowiedzi() == 0):
	post.temat.delete()
	post.delete()
	return HttpResponseRedirect('/dfor/')	
    
    post.delete()
    return HttpResponseRedirect('/dfor/temat/' + str(post.temat.id))


def szukajWPostach(request, slowa):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    
    podzial = Paginator(Post.objects.extra(where=["tekst_tsv @@ plainto_tsquery('public.polish', '%s')" % slowa]), 10)
    strona = request.GET.get('strona')
    try:
	posty = podzial.page(strona)
    except PageNotAnInteger:
	posty = podzial.page(1)
    except EmptyPage:
	posty = podzial.page(podzial.num_pages)
    
    return render_to_response("lista_postow.html", {'posty': posty, 'tytul': 'Wyniki wyszykiwania w postach', 'zadanie': 'szukaj_wyniki', 'dodatek': '&post=' + slowa, 'media': settings.MEDIA_URL, 'uzytkownik': uzytkownik})


def szukajWTematach(request, slowa):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    
    podzial = Paginator(Temat.objects.extra(where=["tytul_tsv @@ plainto_tsquery('public.polish', '%s')" % slowa]), 25)
    strona = request.GET.get('strona')
    try:
	tematy = podzial.page(strona)
    except PageNotAnInteger:
	tematy = podzial.page(1)
    except EmptyPage:
	tematy = podzial.page(podzial.num_pages)
    
    return render_to_response("lista_tematow.html", {'tematy': tematy, 'tytul': 'Wyniki wyszykiwania w tematach', 'zadanie': 'szukaj_wyniki', 'dodatek': '&temat=' + slowa, 'uzytkownik': uzytkownik})


def widokSzukaj(request):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    dane = {}
    dane.update(csrf(request))
    dane['uzytkownik'] = uzytkownik
    
    temat = request.GET.get('temat')
    post = request.GET.get('post')
    strona = request.GET.get('strona')
    
    if request.method == "POST":
	form = formularzSzukaj(request.POST)
	if form.is_valid():
	    slowa = form.cleaned_data['slowa']
	    wybor = form.cleaned_data['wybor']
	    if wybor == 'temat':
		return szukajWTematach(request, slowa)	
	    elif wybor == 'post':	
		return szukajWPostach(request, slowa)
    elif strona:
	if temat:
	    return szukajWTematach(request, temat)
	if post:
	    return szukajWPostach(request, post)
    else:
	form = formularzSzukaj(initial={'wybor': 'post'})
	
    dane['form'] = form
	
    return render_to_response('formularz_szukaj.html', dane)


def widokUzytkownicy(request):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    if (not request.user.is_authenticated()):
      return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
      
    podzial = Paginator(Uzytkownik.objects.all(), 25)
    strona = request.GET.get('strona')
    try:
	uzytkownicy = podzial.page(strona)
    except PageNotAnInteger:
	uzytkownicy = podzial.page(1)
    except EmptyPage:
	uzytkownicy = podzial.page(podzial.num_pages)
      
    return render_to_response("lista_uzytkownkow.html", {'uzytkownicy': uzytkownicy, 'uzytkownik': uzytkownik})


def widokUzytkownik(request, id):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    if (not request.user.is_authenticated()):
      return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
      
    return render_to_response("uzytkownik.html", {'uzytk': Uzytkownik.objects.get(id=id), 'media': settings.MEDIA_URL, 'uzytkownik': uzytkownik})


def zapiszAvatar(plik, nazwa):  
    with open(nazwa, 'wb+') as destination:
        for chunk in plik.chunks():
            destination.write(chunk)


def widokProfil(request):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    if (not request.user.is_authenticated()):
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
	    else:
		profil = formDodatkowe.save(commit=False)
		profil.avatar = ''
		profil.save()
		formDodatkowe.save_m2m()

	    return HttpResponseRedirect('/dfor/uzytkownik/' + str(uzytkownik.id))
    else:
	formGlowne = formularzProfilGlowne(instance=uzytkownik.uzytkownik)
	formDodatkowe = formularzProfilDodatkowe(instance=uzytkownik)
	
    dane['formGlowne'] = formGlowne
    dane['formDodatkowe'] = formDodatkowe
    dane['uzytkownik'] = uzytkownik
    
    return render_to_response('formularz_profil.html', dane)


def widokZmianaHasla(request):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    if (not request.user.is_authenticated()):
      return HttpResponseRedirect('/dfor/zaloguj/?next=' + request.path)
    dane = {}
    dane.update(csrf(request))
    if request.method == "POST":
	form = formularzProfilHaslo(request.POST)
	if form.is_valid():
	    uzytkownik.uzytkownik.set_password(form.cleaned_data['noweHaslo1'])
	    uzytkownik.uzytkownik.save()
	    return HttpResponseRedirect('/dfor/')
    else:
	form = formularzProfilHaslo(initial={'idUzytkownika': uzytkownik.id})
	
    dane['form'] = form
    dane['uzytkownik'] = uzytkownik
    
    return render_to_response('formularz_zmiana_hasla.html', dane)


def widokZarejestruj(request):
    uzytkownik = sprUzytkownika(request, request.user.is_authenticated())
    if (request.user.is_authenticated()):
      return HttpResponseRedirect('/dfor/')
    dane = {}
    dane.update(csrf(request))
    if request.method == "POST":
	formGlowne = formularzRejestrujGlowne(request.POST)	
	formDodatkowe = formularzProfilDodatkowe(request.POST)
	formHaslo = formularzRejestrujlHaslo(request.POST)
	
	if formGlowne.is_valid() and formDodatkowe.is_valid() and formHaslo.is_valid(): 
	    glowne = formGlowne.save()
	    glowne.set_password(formHaslo.cleaned_data['haslo1'])
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
	formHaslo = formularzRejestrujlHaslo()
	
    dane['formGlowne'] = formGlowne
    dane['formDodatkowe'] = formDodatkowe
    dane['formHaslo'] = formHaslo
    
    return render_to_response('formularz_zarejestruj.html', dane)


def widokWyloguj(request):
    logout(request)
    return HttpResponseRedirect('/dfor')
