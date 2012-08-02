from django.forms import ModelForm
from models import *


class UzytkownikForm(ModelForm):
    class Meta:
	model = Uzytkownik
	
class PostForm(ModelForm):
  class Meta:
    model = Post
