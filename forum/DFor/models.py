# -*- encoding: utf-8 -*-

from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from datetime import date

PLEC = (('K', 'Kobieta'),('M', 'Mezczyzna'))

class Uzytkownik(models.Model):
    uzytkownik = models.OneToOneField(User)
    data_urodzenia = models.DateField(blank=True, null=True, verbose_name='Data urodzenia')
    plec = models.CharField(blank=True, max_length=1, choices=PLEC, verbose_name='Płeć')
    miejscowosc = models.CharField(blank=True, max_length=100, verbose_name='Miejscowość')
    avatar = models.ImageField(blank=True, upload_to='avatars', verbose_name='Avatar')
    podpis = models.TextField(blank=True, verbose_name='Podpis')
  
    def __unicode__(self):
	return self.uzytkownik.username
    
    def utworz_uzytkownika(sender, instance, created, **kwargs):
	if created:
	    Uzytkownik.objects.create(uzytkownik=instance)
      
    post_save.connect(utworz_uzytkownika, sender=User)
  
    def wiek(self):
	return int((abs(date.today() - self.data_urodzenia)).days/365.25);
      
    def iloscPostow(self):
	return Post.objects.filter(autor=self).count()


class Forum(models.Model):
    nazwa = models.CharField(max_length=70)
    opis = models.CharField(max_length=150, blank=True)
  
    def __unicode__(self):
	return self.nazwa
	
    def tematy(self):
	return Temat.objects.filter(forum=self)

    
class Temat(models.Model):
    tytul = models.CharField(max_length=70, verbose_name='Tytuł', unique=True)
    data_utworzenia = models.DateTimeField(auto_now_add=True)
    forum = models.ForeignKey(Forum)
  
    def __unicode__(self):
	return self.tytul
	
    def posty(self):
	return Post.objects.filter(temat=self).order_by('data_utworzenia')
    
    def iloscOdpowiedzi(self):
	return Post.objects.filter(temat=self).count() - 1
  
    def autorTematu(self):
	return Post.objects.filter(temat=self).order_by('data_utworzenia')[0].autor
     
    def ostatniPost(self):
	return Post.objects.filter(temat=self).order_by('-data_modyfikacji')[0]


class Post(models.Model):
    autor = models.ForeignKey(Uzytkownik)
    temat = models.ForeignKey(Temat)
    data_utworzenia = models.DateTimeField(auto_now_add=True)
    data_modyfikacji = models.DateTimeField(auto_now=True)
    tekst = models.TextField()
    safe = models.BooleanField(default=False)
  
    def __unicode__(self):
	return self.autor.uzytkownik.username + ' ' + str(self.data_modyfikacji)
    
    def zmieniony(self):
	return ((self.data_modyfikacji - self.data_utworzenia).seconds) != 0
