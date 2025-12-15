# Скрипт для создания ветки и загрузки на GitHub
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Создание ветки для Pull Request" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Переход в папку проекта
Set-Location $PSScriptRoot

# Проверка текущей ветки
Write-Host "Проверка текущего состояния..." -ForegroundColor Yellow
$currentBranch = git branch --show-current
Write-Host "Текущая ветка: $currentBranch" -ForegroundColor Cyan

# Проверка наличия коммитов
$hasCommits = git rev-parse --verify HEAD 2>$null
if (-not $hasCommits) {
    Write-Host "Нет коммитов. Создание первого коммита..." -ForegroundColor Yellow
    git add .
    git commit -m "Initial commit: Django diary application"
}

# Переключение на main (если не на ней)
if ($currentBranch -ne "main" -and $currentBranch -ne "master") {
    Write-Host "Переключение на ветку main..." -ForegroundColor Yellow
    # Проверяем, существует ли main
    $mainExists = git branch --list main
    if (-not $mainExists) {
        # Проверяем master
        $masterExists = git branch --list master
        if ($masterExists) {
            git checkout master
            git branch -M main
        } else {
            git checkout -b main
        }
    } else {
        git checkout main
    }
}

# Получение последних изменений с GitHub (если есть)
Write-Host "Получение изменений с GitHub..." -ForegroundColor Yellow
git pull origin main 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Не удалось получить изменения (это нормально, если репозиторий новый)" -ForegroundColor Yellow
}

# Создание новой ветки
Write-Host ""
Write-Host "Создание новой ветки feature/improvements..." -ForegroundColor Yellow
git checkout -b feature/improvements

# Добавление всех файлов
Write-Host "Добавление файлов..." -ForegroundColor Yellow
git add .

# Проверка наличия изменений для коммита
$status = git status --porcelain
if ($status) {
    Write-Host "Создание коммита..." -ForegroundColor Yellow
    git commit -m "Add improvements: create feature branch for PR"
} else {
    Write-Host "Нет изменений для коммита" -ForegroundColor Green
}

# Загрузка ветки на GitHub
Write-Host ""
Write-Host "Загрузка ветки на GitHub..." -ForegroundColor Yellow
git push -u origin feature/improvements

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Успешно! Ветка создана и загружена." -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Теперь вы можете создать Pull Request:" -ForegroundColor Cyan
    Write-Host "1. Перейдите на https://github.com/doboleshev/diary-app" -ForegroundColor White
    Write-Host "2. Нажмите 'Compare & pull request'" -ForegroundColor White
    Write-Host "3. Заполните описание" -ForegroundColor White
    Write-Host "4. Нажмите 'Create pull request'" -ForegroundColor White
} else {
    Write-Host ""
    Write-Host "Ошибка при загрузке ветки. Проверьте подключение к GitHub." -ForegroundColor Red
}

Write-Host ""

