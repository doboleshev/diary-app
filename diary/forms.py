from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import DiaryEntry


class DiaryEntryForm(forms.ModelForm):
    """Форма для создания и редактирования записей дневника"""
    class Meta:
        model = DiaryEntry
        fields = ['title', 'content']
        widgets = {
            'title': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Введите заголовок записи'
            }),
            'content': forms.Textarea(attrs={
                'class': 'form-control',
                'rows': 10,
                'placeholder': 'Введите содержание записи'
            }),
        }
        labels = {
            'title': 'Заголовок',
            'content': 'Содержание',
        }


class SearchForm(forms.Form):
    """Форма для поиска записей"""
    query = forms.CharField(
        max_length=200,
        required=False,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Поиск по заголовку или содержанию...'
        }),
        label='Поиск'
    )


class CustomUserCreationForm(UserCreationForm):
    """Кастомная форма регистрации с Bootstrap стилями"""
    username = forms.CharField(
        max_length=150,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Введите имя пользователя'
        }),
        label='Имя пользователя'
    )
    password1 = forms.CharField(
        widget=forms.PasswordInput(attrs={
            'class': 'form-control',
            'placeholder': 'Введите пароль'
        }),
        label='Пароль'
    )
    password2 = forms.CharField(
        widget=forms.PasswordInput(attrs={
            'class': 'form-control',
            'placeholder': 'Подтвердите пароль'
        }),
        label='Подтверждение пароля'
    )

    class Meta:
        model = User
        fields = ('username', 'password1', 'password2')

