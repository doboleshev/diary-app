# Скрипт для создания ветки и загрузки на GitHub
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Создание ветки для Pull Request" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Переход в папку проекта
Set-Location $PSScriptRoot

# Проверка инициализации Git
if (-not (Test-Path ".git")) {
    Write-Host "Инициализация Git репозитория..." -ForegroundColor Yellow
    git init
}

# Проверка подключения удаленного репозитория
$remoteExists = git remote | Select-String "origin"
if (-not $remoteExists) {
    Write-Host "Подключение удаленного репозитория..." -ForegroundColor Yellow
    git remote add origin git@github.com:doboleshev/diary-app.git
} else {
    Write-Host "Удаленный репозиторий уже подключен" -ForegroundColor Green
}

# Проверка текущей ветки
$currentBranch = git branch --show-current
Write-Host "Текущая ветка: $currentBranch" -ForegroundColor Cyan
Write-Host ""

# Создание новой ветки
Write-Host "Создание новой ветки feature/improvements..." -ForegroundColor Yellow
git checkout -b feature/improvements

# Добавление всех файлов
Write-Host "Добавление файлов..." -ForegroundColor Yellow
git add .

# Проверка наличия незакоммиченных изменений
$status = git status --porcelain
if ($status) {
    Write-Host "Создание коммита..." -ForegroundColor Yellow
    git commit -m "Add improvements: create feature branch for PR"
}

# Загрузка ветки на GitHub
Write-Host ""
Write-Host "Загрузка ветки на GitHub..." -ForegroundColor Yellow
git push -u origin feature/improvements

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Готово! Ветка создана и загружена." -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Теперь вы можете создать Pull Request:" -ForegroundColor Cyan
Write-Host "1. Перейдите на https://github.com/doboleshev/diary-app" -ForegroundColor White
Write-Host "2. Нажмите 'Compare & pull request'" -ForegroundColor White
Write-Host "3. Заполните описание" -ForegroundColor White
Write-Host "4. Нажмите 'Create pull request'" -ForegroundColor White
Write-Host ""

