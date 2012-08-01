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
  autor = models.ForeignKey(Uzytkownik)
  data_utworzenia = models.DateTimeField(auto_now_add=True)
  data_modyfikacji = models.DateTimeField(auto_now=True)
  tekst = models.TextField()
  
  def __unicode__(self):
    return self.autor.uzytkownik.username + ' ' + str(self.data_modyfikacji)
  
class Temat(models.Model):
  tytul = models.CharField(max_length=70)
  posty = models.ManyToManyField(Post)
  
  def __unicode__(self):
    return self.tytul
  
  def autorTematu(self):
      return self.posty.all()[0].autor
      
  def ostatniPost(self):
      return self.posty.order_by('-data_modyfikacji').all()[0]
  
class Forum(models.Model):
  nazwa = models.CharField(max_length=70)
  opis = models.CharField(max_length=150, blank=True)
  tematy = models.ManyToManyField(Temat, blank=True)
  
  def __unicode__(self):
    return self.nazwa
