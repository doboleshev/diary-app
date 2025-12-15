# Инструкция по созданию Pull Request

## Шаг 1: Инициализация Git (если еще не сделано)

Откройте терминал в папке проекта и выполните:

```bash
cd C:\Users\Денис\Desktop\diary-app

# Инициализация Git (если еще не сделано)
git init

# Подключение удаленного репозитория
git remote add origin git@github.com:doboleshev/diary-app.git

# Добавление всех файлов
git add .

# Создание первого коммита (если еще нет коммитов)
git commit -m "Initial commit: Django diary application"
```

## Шаг 2: Создание и загрузка основной ветки (main/master)

```bash
# Переименование ветки в main (если нужно)
git branch -M main

# Загрузка основной ветки на GitHub
git push -u origin main
```

## Шаг 3: Создание ветки для Pull Request

```bash
# Создание новой ветки
git checkout -b feature/improvements

# Или если хотите другое название:
# git checkout -b feature/add-features
# git checkout -b fix/bug-fixes
# git checkout -b docs/update-readme
```

## Шаг 4: Внесение изменений (опционально)

Если хотите внести изменения перед созданием PR:

```bash
# Внесите изменения в файлы
# ...

# Добавьте измененные файлы
git add .

# Создайте коммит
git commit -m "Add improvements to diary app"
```

## Шаг 5: Загрузка ветки на GitHub

```bash
# Загрузите ветку на GitHub
git push -u origin feature/improvements
```

## Шаг 6: Создание Pull Request на GitHub

1. Перейдите на https://github.com/doboleshev/diary-app
2. Вы увидите уведомление о новой ветке - нажмите **"Compare & pull request"**
   
   ИЛИ
   
   Нажмите на вкладку **"Pull requests"** → **"New pull request"**
3. Выберите:
   - **base:** `main` (или `master`)
   - **compare:** `feature/improvements`
4. Заполните:
   - **Title:** Краткое описание изменений
   - **Description:** Подробное описание того, что было изменено
5. Нажмите **"Create pull request"**

## Альтернативный способ (через скрипт)

Запустите файл `create_pr_branch.bat` - он автоматически выполнит все шаги.

## Полезные команды Git

```bash
# Просмотр всех веток
git branch -a

# Переключение между ветками
git checkout main
git checkout feature/improvements

# Просмотр статуса
git status

# Просмотр истории коммитов
git log --oneline

# Просмотр удаленных репозиториев
git remote -v
```

## Если нужно обновить существующую ветку

```bash
# Переключитесь на ветку
git checkout feature/improvements

# Внесите изменения
# ...

# Добавьте и закоммитьте
git add .
git commit -m "Update: описание изменений"

# Загрузите обновления
git push
```

## Если нужно синхронизировать с main

```bash
# Переключитесь на main
git checkout main

# Получите последние изменения
git pull origin main

# Вернитесь на вашу ветку
git checkout feature/improvements

# Объедините изменения из main
git merge main

# Или используйте rebase (более чистая история)
git rebase main
```

