from django.forms import ModelForm, Textarea, HiddenInput, TextInput
from models import *

class formularzProfilGlowne(ModelForm):
    class Meta:
	model = User
	fields = ('first_name', 'last_name', 'email')

class formularzProfilDodatkowe(ModelForm):
    class Meta:
	model = Uzytkownik
	fields = ('data_urodzenia', 'plec', 'miejscowosc', 'avatar', 'podpis')

class formularzPost(ModelForm):
    class Meta:
	model = Post
	fields = ('tekst', 'safe')
	widgets = {
            'tekst': Textarea(attrs={'cols': 107, 'rows': 30}),
            'safe': HiddenInput()
        }

class formularzTemat(ModelForm):
    class Meta:
	model = Temat
	fields = ('tytul',)
	widgets = {
	    'tytul': TextInput(attrs={'size': 70, }),
	}