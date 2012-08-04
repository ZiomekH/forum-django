from django.forms import ModelForm, Textarea, HiddenInput
from models import *

class formularzUzytkownik(ModelForm):
    class Meta:
	model = Uzytkownik
	fields = ('data_urodzenia', 'plec', 'miejscowosc', 'podpis')
	
	
class formularzPost(ModelForm):
    class Meta:
	model = Post
	fields = ('tekst', 'safe')
	widgets = {
            'tekst': Textarea(attrs={'cols': 107, 'rows': 20}),
            'safe': HiddenInput()
        }

class formularzTemat(ModelForm):
    class Meta:
	model = Temat
	fields = ('tytul',)