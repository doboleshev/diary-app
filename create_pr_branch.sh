#!/bin/bash
# Скрипт для создания ветки и Pull Request (для Git Bash)

echo "========================================"
echo "Создание ветки для Pull Request"
echo "========================================"
echo

# Переход в папку проекта
cd "$(dirname "$0")"

# Проверка инициализации Git
if [ ! -d ".git" ]; then
    echo "Инициализация Git репозитория..."
    git init
fi

# Проверка подключения удаленного репозитория
if ! git remote | grep -q "origin"; then
    echo "Подключение удаленного репозитория..."
    git remote add origin git@github.com:doboleshev/diary-app.git
fi

# Добавление всех файлов
echo
echo "Добавление файлов..."
git add .

# Проверка наличия коммитов
if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
    echo "Создание первого коммита..."
    git commit -m "Initial commit: Django diary application"
fi

# Создание новой ветки для PR
echo
echo "Создание новой ветки feature/improvements..."
git checkout -b feature/improvements

# Загрузка ветки на GitHub
echo
echo "Загрузка ветки на GitHub..."
git push -u origin feature/improvements

echo
echo "========================================"
echo "Готово!"
echo "========================================"
echo
echo "Теперь вы можете создать Pull Request:"
echo "1. Перейдите на https://github.com/doboleshev/diary-app"
echo "2. Нажмите 'Compare & pull request'"
echo "3. Заполните описание"
echo "4. Нажмите 'Create pull request'"
echo

