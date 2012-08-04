from django.forms import ModelForm, Textarea
from models import *

class formularzUzytkownik(ModelForm):
    class Meta:
	model = Uzytkownik
	fields = ('data_urodzenia', 'plec', 'miejscowosc', 'podpis')
	
	
class formularzPost(ModelForm):
    class Meta:
	model = Post
	fields = ('tekst',)
	widgets = {
            'tekst': Textarea(attrs={'cols': 80, 'rows': 20}),
        }

class formularzTemat(ModelForm):
    class Meta:
	model = Temat
	fields = ('tytul',)