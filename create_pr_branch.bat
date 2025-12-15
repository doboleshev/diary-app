@echo off
chcp 65001 >nul
echo ========================================
echo Создание ветки для Pull Request
echo ========================================
echo.

REM Переход в папку проекта
cd /d "%~dp0"

REM Проверка инициализации Git
if not exist ".git" (
    echo Инициализация Git репозитория...
    git init
)

REM Проверка подключения удаленного репозитория
git remote -v | findstr "origin" >nul
if errorlevel 1 (
    echo Подключение удаленного репозитория...
    git remote add origin git@github.com:doboleshev/diary-app.git
)

REM Добавление всех файлов
echo.
echo Добавление файлов...
git add .

REM Проверка наличия коммитов
git log --oneline -1 >nul 2>&1
if errorlevel 1 (
    echo Создание первого коммита...
    git commit -m "Initial commit: Django diary application"
)

REM Создание новой ветки для PR
echo.
echo Создание новой ветки feature/improvements...
git checkout -b feature/improvements

REM Загрузка ветки на GitHub
echo.
echo Загрузка ветки на GitHub...
git push -u origin feature/improvements

echo.
echo ========================================
echo Готово!
echo ========================================
echo.
echo Теперь вы можете создать Pull Request:
echo 1. Перейдите на https://github.com/doboleshev/diary-app
echo 2. Нажмите "Compare & pull request"
echo 3. Заполните описание
echo 4. Нажмите "Create pull request"
echo.
pause

