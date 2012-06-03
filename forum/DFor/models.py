from django.db import models

# Create your models here.

class Uzytkownik(models.Model):
  login = models.CharField(max_length=30)
  haslo = models.CharField(max_length=32)
  email = models.EmailField(max_length=254)
  data_urodzenia = models.DateField()
  plec = models.CharField(max_length=1)
  miejscowosc = models.CharField(max_length=100)
  avatar = models.ImageField(upload_to='avatars')
  podpis = models.TextField()
  
  def __unicode__(self):
    return self.login
  
class Post(models.Model):
  uzytkownik = models.ForeignKey(Uzytkownik)
  tytul = models.CharField(max_length=100)
  data_utworzenia = models.DateTimeField(auto_now_add=True)
  data_modyfikacji = models.DateTimeField(auto_now=True)
  tekst = models.TextField()
  
  def __unicode__(self):
    return self.tytul + ' ' + self.uzytkownik.login + ' ' + str(self.data_utworzenia)
  
class Temat(models.Model):
  tytul = models.CharField(max_length=100)
  posty = models.ManyToManyField(Post)
  
  def __unicode__(self):
    return self.tytul
  
class Forum(models.Model):
  nazwa = models.CharField(max_length=100)
  tematy = models.ManyToManyField(Temat)
  
  def __unicode__(self):
    return self.nazwa