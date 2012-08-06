# -*- encoding: utf-8 -*-

from django import forms
from django.forms import ModelForm, Textarea, HiddenInput, TextInput, PasswordInput
from models import *

class formularzProfilGlowne(ModelForm):
    class Meta:
	model = User
	fields = ('email', 'first_name', 'last_name')

class formularzProfilDodatkowe(ModelForm):
    class Meta:
	model = Uzytkownik
	fields = ('data_urodzenia', 'plec', 'miejscowosc', 'avatar', 'podpis')
	widgets = {
	    'podpis': Textarea(attrs={'cols': 27, 'rows': 5}),
	}

class formularzProfilHaslo(forms.Form):
    idUzytkownika = forms.IntegerField(widget=forms.HiddenInput())
    stareHaslo = forms.CharField(widget=forms.PasswordInput, label="Stare hasło")
    noweHaslo1 = forms.CharField(widget=forms.PasswordInput, label="Nowe hasło")
    noweHaslo2 = forms.CharField(widget=forms.PasswordInput, label="Powtórz hasło")
    
    def clean(self):
	cleaned_data = super(formularzProfilHaslo, self).clean()
	idUzytkownika = cleaned_data.get("idUzytkownika")
	stareHaslo = cleaned_data.get("stareHaslo")
	noweHaslo1 = cleaned_data.get("noweHaslo1")
	noweHaslo2 = cleaned_data.get("noweHaslo2")
	
	if not Uzytkownik.objects.get(id = idUzytkownika).uzytkownik.check_password(stareHaslo):
	    raise forms.ValidationError("Niepoprawne obecne hasło!")
	
	if noweHaslo1 != noweHaslo2:
            raise forms.ValidationError("Nowe hasła są różne!")
	
        return cleaned_data

class formularzRejestrujlHaslo(forms.Form):
    haslo1 = forms.CharField(widget=forms.PasswordInput, label="Hasło")
    haslo2 = forms.CharField(widget=forms.PasswordInput, label="Powtórz hasło")
    
    def clean(self):
	cleaned_data = super(formularzRejestrujlHaslo, self).clean()
	haslo1 = cleaned_data.get("haslo1")
	haslo2 = cleaned_data.get("haslo2")
	
	if haslo1 != haslo2:
            raise forms.ValidationError("Hasła są różne!")
	
        return cleaned_data
        
class formularzRejestrujGlowne(ModelForm):
    class Meta:
	model = User
	fields = ('username', 'email', 'first_name', 'last_name')
	widgets = {
	    'password': PasswordInput(),
	}
	
    def clean(self):
	cleaned_data = super(formularzRejestrujGlowne, self).clean()
	email = cleaned_data.get("email")
	
	if not email:
	    raise forms.ValidationError("Brak adresu e-mail!")
	
	return cleaned_data

        
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