#!/usr/bin/env python
"""Скрипт для проверки настройки проекта"""
import sys
import os

print("=" * 50)
print("Проверка настройки Django проекта")
print("=" * 50)

# Проверка Python
print(f"\n1. Версия Python: {sys.version}")

# Проверка Django
try:
    import django
    print(f"2. Django установлен: {django.get_version()}")
except ImportError:
    print("2. ❌ Django НЕ установлен!")
    print("   Выполните: pip install Django")
    sys.exit(1)

# Проверка структуры проекта
print("\n3. Проверка структуры проекта:")
required_files = [
    'manage.py',
    'diary_project/settings.py',
    'diary/models.py',
    'diary/views.py',
    'diary/urls.py',
]

for file in required_files:
    if os.path.exists(file):
        print(f"   ✓ {file}")
    else:
        print(f"   ❌ {file} - НЕ НАЙДЕН!")

# Проверка настроек Django
print("\n4. Проверка настроек Django:")
try:
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'diary_project.settings')
    django.setup()
    print("   ✓ Настройки Django загружены успешно")
    
    from django.conf import settings
    print(f"   ✓ INSTALLED_APPS: {len(settings.INSTALLED_APPS)} приложений")
    print(f"   ✓ DEBUG: {settings.DEBUG}")
    
except Exception as e:
    print(f"   ❌ Ошибка при загрузке настроек: {e}")
    sys.exit(1)

# Проверка миграций
print("\n5. Проверка миграций:")
try:
    from django.core.management import call_command
    from io import StringIO
    
    output = StringIO()
    call_command('showmigrations', '--list', stdout=output, no_color=True)
    migrations = output.getvalue()
    
    if 'diary' in migrations:
        print("   ✓ Миграции найдены")
    else:
        print("   ⚠ Миграции не найдены. Выполните: python manage.py makemigrations")
        
except Exception as e:
    print(f"   ⚠ Не удалось проверить миграции: {e}")

print("\n" + "=" * 50)
print("Проверка завершена!")
print("=" * 50)
print("\nЕсли все проверки пройдены, попробуйте:")
print("  python manage.py makemigrations")
print("  python manage.py migrate")
print("  python manage.py runserver")

