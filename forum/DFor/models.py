from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save

class Uzytkownik(models.Model):
  uzytkownik = models.OneToOneField(User)
  data_urodzenia = models.DateField(blank=True, null=True)
  plec = models.CharField(blank=True, max_length=1)
  miejscowosc = models.CharField(blank=True, max_length=100)
  avatar = models.ImageField(blank=True, upload_to='avatars')
  podpis = models.TextField(blank=True)
  
  def __unicode__(self):
    return self.uzytkownik.username
    
  def utworz_uzytkownika(sender, instance, created, **kwargs):
    if created:
      Uzytkownik.objects.create(uzytkownik=instance)
      
  post_save.connect(utworz_uzytkownika, sender=User)

class Post(models.Model):
  uzytkownik = models.ForeignKey(Uzytkownik)
  data_utworzenia = models.DateTimeField(auto_now_add=True)
  data_modyfikacji = models.DateTimeField(auto_now=True)
  tekst = models.TextField()
  
  def __unicode__(self):
    return self.uzytkownik.uzytkownik.username + ' ' + str(self.data_utworzenia)
  
class Temat(models.Model):
  tytul = models.CharField(max_length=100)
  posty = models.ManyToManyField(Post)
  
  def __unicode__(self):
    return self.tytul
  
class Forum(models.Model):
  nazwa = models.CharField(max_length=100)
  tematy = models.ManyToManyField(Temat, blank=True)
  
  def __unicode__(self):
    return self.nazwa