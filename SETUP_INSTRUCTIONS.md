# Инструкция по исправлению проблем с запуском сервера

## Возможные проблемы и решения:

### 1. Django не установлен

**Симптомы:** Ошибка `ModuleNotFoundError: No module named 'django'`

**Решение:**
```bash
pip install Django
# или
pip install -r requirements.txt
```

### 2. Не выполнены миграции

**Симптомы:** Ошибки связанные с базой данных

**Решение:**
```bash
python manage.py makemigrations
python manage.py migrate
```

### 3. Проблемы с путями

**Убедитесь, что вы находитесь в правильной директории:**
```bash
cd C:\Users\Денис\Desktop\diary-app
python manage.py runserver
```

### 4. Порт уже занят

**Симптомы:** Ошибка `[Errno 10048] Only one usage of each socket address`

**Решение:**
```bash
# Используйте другой порт
python manage.py runserver 8001
```

### 5. Проверка установки

**Запустите скрипт диагностики:**
```bash
python check_setup.py
```

## Пошаговая инструкция для первого запуска:

1. **Установите Django:**
   ```bash
   pip install Django
   ```

2. **Перейдите в папку проекта:**
   ```bash
   cd C:\Users\Денис\Desktop\diary-app
   ```

3. **Выполните миграции:**
   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

4. **Создайте суперпользователя (опционально):**
   ```bash
   python manage.py createsuperuser
   ```

5. **Запустите сервер:**
   ```bash
   python manage.py runserver
   ```

6. **Откройте браузер:**
   Перейдите по адресу: http://127.0.0.1:8000/

## Если ничего не помогает:

1. Проверьте версию Python (должна быть 3.8+):
   ```bash
   python --version
   ```

2. Проверьте, что Django установлен:
   ```bash
   python -c "import django; print(django.get_version())"
   ```

3. Проверьте структуру проекта - все файлы должны быть на месте

4. Попробуйте запустить с подробным выводом ошибок:
   ```bash
   python manage.py runserver --verbosity 2
   ```

