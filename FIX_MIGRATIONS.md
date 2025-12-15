# Исправление проблемы с миграциями

## Проблема
При выполнении `python manage.py makemigrations` выводится "No changes detected"

## Решение

Выполните команды в следующем порядке:

```bash
# 1. Создайте миграции для приложения diary
python manage.py makemigrations diary

# 2. Если это не помогло, создайте миграции для всех приложений
python manage.py makemigrations

# 3. Примените миграции
python manage.py migrate

# 4. Теперь запустите сервер
python manage.py runserver
```

## Если миграции все еще не создаются:

1. Убедитесь, что приложение `diary` добавлено в `INSTALLED_APPS` в `diary_project/settings.py`

2. Проверьте, что файл `diary/apps.py` существует и правильно настроен

3. Попробуйте удалить папку `__pycache__` (если есть):
   ```bash
   # Windows PowerShell
   Remove-Item -Recurse -Force __pycache__
   Remove-Item -Recurse -Force diary\__pycache__
   Remove-Item -Recurse -Force diary_project\__pycache__
   ```

4. Попробуйте создать миграции с флагом --empty:
   ```bash
   python manage.py makemigrations diary --empty
   ```

