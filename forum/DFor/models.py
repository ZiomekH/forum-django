from django.db import models
from django.contrib.auth.models import User

class Uzytkownik(models.Model):
  uzytkownik = models.OneToOneField(User)
  data_urodzenia = models.DateField(blank=True, null=True)
  plec = models.CharField(blank=True, max_length=1)
  miejscowosc = models.CharField(blank=True, max_length=100)
  avatar = models.ImageField(blank=True, upload_to='avatars')
  podpis = models.TextField(blank=True)
  
  def __unicode__(self):
    return self.uzytkownik.username
  
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
