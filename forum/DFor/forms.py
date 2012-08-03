from django.forms import ModelForm
from models import *


class formularzUzytkownik(ModelForm):
    class Meta:
	model = Uzytkownik
	fields = ('data_urodzenia', 'plec', 'miejscowosc', 'podpis')
	
	
class formularzPost(ModelForm):
    class Meta:
	model = Post
	fields = ('tekst',)
	

class formularzTemat(ModelForm):
    class Meta:
	model = Temat
	fields = ('tytul',)