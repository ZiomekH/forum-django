from django.forms import ModelForm, Textarea, HiddenInput, TextInput, PasswordInput
from models import *

class formularzProfilGlowne(ModelForm):
    class Meta:
	model = User
	fields = ('email', 'first_name', 'last_name')
	
class formularzRejestrujGlowne(ModelForm):
    class Meta:
	model = User
	fields = ('username', 'password', 'email', 'first_name', 'last_name')
	widgets = {
	    'password': PasswordInput(),
	}

class formularzProfilDodatkowe(ModelForm):
    class Meta:
	model = Uzytkownik
	fields = ('data_urodzenia', 'plec', 'miejscowosc', 'avatar', 'podpis')
	widgets = {
	    'podpis': Textarea(attrs={'cols': 27, 'rows': 5}),
	}

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