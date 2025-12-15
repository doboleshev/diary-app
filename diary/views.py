from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth import login, authenticate
from .forms import CustomUserCreationForm
from django.contrib import messages
from django.db.models import Q
from .models import DiaryEntry
from .forms import DiaryEntryForm, SearchForm


def register(request):
    """Регистрация нового пользователя"""
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            username = form.cleaned_data.get('username')
            messages.success(request, f'Аккаунт создан для {username}!')
            login(request, user)
            return redirect('diary:entry_list')
    else:
        form = CustomUserCreationForm()
    return render(request, 'diary/register.html', {'form': form})


def user_login(request):
    """Вход пользователя в систему"""
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('diary:entry_list')
        else:
            messages.error(request, 'Неверное имя пользователя или пароль.')
    return render(request, 'diary/login.html')


@login_required
def entry_list(request):
    """Список всех записей пользователя"""
    entries = DiaryEntry.objects.filter(author=request.user)
    
    # Поиск
    search_form = SearchForm(request.GET)
    if search_form.is_valid() and search_form.cleaned_data['query']:
        query = search_form.cleaned_data['query']
        entries = entries.filter(
            Q(title__icontains=query) | Q(content__icontains=query)
        )
    
    context = {
        'entries': entries,
        'search_form': search_form,
    }
    return render(request, 'diary/entry_list.html', context)


@login_required
def entry_detail(request, pk):
    """Детальный просмотр записи"""
    entry = get_object_or_404(DiaryEntry, pk=pk, author=request.user)
    return render(request, 'diary/entry_detail.html', {'entry': entry})


@login_required
def entry_create(request):
    """Создание новой записи"""
    if request.method == 'POST':
        form = DiaryEntryForm(request.POST)
        if form.is_valid():
            entry = form.save(commit=False)
            entry.author = request.user
            entry.save()
            messages.success(request, 'Запись успешно создана!')
            return redirect('diary:entry_detail', pk=entry.pk)
    else:
        form = DiaryEntryForm()
    return render(request, 'diary/entry_form.html', {'form': form, 'title': 'Создать запись'})


@login_required
def entry_edit(request, pk):
    """Редактирование записи"""
    entry = get_object_or_404(DiaryEntry, pk=pk, author=request.user)
    if request.method == 'POST':
        form = DiaryEntryForm(request.POST, instance=entry)
        if form.is_valid():
            form.save()
            messages.success(request, 'Запись успешно обновлена!')
            return redirect('diary:entry_detail', pk=entry.pk)
    else:
        form = DiaryEntryForm(instance=entry)
    return render(request, 'diary/entry_form.html', {'form': form, 'entry': entry, 'title': 'Редактировать запись'})


@login_required
def entry_delete(request, pk):
    """Удаление записи"""
    entry = get_object_or_404(DiaryEntry, pk=pk, author=request.user)
    if request.method == 'POST':
        entry.delete()
        messages.success(request, 'Запись успешно удалена!')
        return redirect('diary:entry_list')
    return render(request, 'diary/entry_confirm_delete.html', {'entry': entry})

