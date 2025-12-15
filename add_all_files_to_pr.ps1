# Скрипт для добавления всех файлов проекта в PR
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Добавление всех файлов в Pull Request" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Переход в папку проекта
Set-Location $PSScriptRoot

# Проверка текущей ветки
$currentBranch = git branch --show-current
Write-Host "Текущая ветка: $currentBranch" -ForegroundColor Cyan

if ($currentBranch -ne "feature/improvements") {
    Write-Host "Переключение на ветку feature/improvements..." -ForegroundColor Yellow
    git checkout feature/improvements
}

# Проверка, какие файлы есть в main, но не в feature/improvements
Write-Host "Проверка различий с main..." -ForegroundColor Yellow
git checkout main
$mainFiles = git ls-files
git checkout feature/improvements
$featureFiles = git ls-files

# Добавление всех файлов проекта
Write-Host "Добавление всех файлов проекта..." -ForegroundColor Yellow
git add .

# Проверка статуса
Write-Host ""
Write-Host "Статус изменений:" -ForegroundColor Cyan
git status --short

# Создание коммита со всеми файлами
Write-Host ""
Write-Host "Создание коммита со всеми файлами проекта..." -ForegroundColor Yellow
git commit -m "Add all project files to feature branch"

# Загрузка на GitHub
Write-Host ""
Write-Host "Загрузка изменений на GitHub..." -ForegroundColor Yellow
git push origin feature/improvements

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Успешно! Все файлы добавлены в PR." -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Теперь в Pull Request будут видны все файлы проекта." -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "Ошибка при загрузке." -ForegroundColor Red
}

Write-Host ""

