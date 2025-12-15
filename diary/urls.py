from django.urls import path
from django.contrib.auth import views as auth_views
from . import views

app_name = 'diary'

urlpatterns = [
    path('', views.entry_list, name='entry_list'),
    path('register/', views.register, name='register'),
    path('login/', views.user_login, name='login'),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
    path('entry/create/', views.entry_create, name='entry_create'),
    path('entry/<int:pk>/', views.entry_detail, name='entry_detail'),
    path('entry/<int:pk>/edit/', views.entry_edit, name='entry_edit'),
    path('entry/<int:pk>/delete/', views.entry_delete, name='entry_delete'),
]

