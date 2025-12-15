# Скрипт для загрузки ветки на GitHub
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Загрузка ветки на GitHub" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Переход в папку проекта
Set-Location $PSScriptRoot

# Проверка текущей ветки
$currentBranch = git branch --show-current
Write-Host "Текущая ветка: $currentBranch" -ForegroundColor Cyan

# Проверка наличия коммитов
$commitCount = (git rev-list --count HEAD 2>$null)
if ($commitCount -eq 0) {
    Write-Host "Нет коммитов. Создание пустого коммита..." -ForegroundColor Yellow
    git commit --allow-empty -m "Initial commit for feature branch"
}

# Проверка, отличается ли ветка от main
$mainExists = git branch --list main
if ($mainExists) {
    $diff = git diff main..feature/improvements --stat
    if (-not $diff) {
        Write-Host "Ветка не отличается от main. Создание пустого коммита..." -ForegroundColor Yellow
        git commit --allow-empty -m "Create feature branch for PR"
    }
}

# Проверка подключения к удаленному репозиторию
$remoteExists = git remote | Select-String "origin"
if (-not $remoteExists) {
    Write-Host "Подключение удаленного репозитория..." -ForegroundColor Yellow
    git remote add origin git@github.com:doboleshev/diary-app.git
}

# Загрузка ветки на GitHub
Write-Host ""
Write-Host "Загрузка ветки на GitHub..." -ForegroundColor Yellow
git push -u origin feature/improvements

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Успешно! Ветка загружена на GitHub." -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Теперь вы можете создать Pull Request:" -ForegroundColor Cyan
    Write-Host "1. Перейдите на https://github.com/doboleshev/diary-app" -ForegroundColor White
    Write-Host "2. Нажмите 'Compare & pull request'" -ForegroundColor White
    Write-Host "3. Заполните описание" -ForegroundColor White
    Write-Host "4. Нажмите 'Create pull request'" -ForegroundColor White
} else {
    Write-Host ""
    Write-Host "Ошибка при загрузке. Попробуйте:" -ForegroundColor Red
    Write-Host "1. Создать пустой коммит: git commit --allow-empty -m 'Create feature branch'" -ForegroundColor Yellow
    Write-Host "2. Или проверить подключение: git remote -v" -ForegroundColor Yellow
}

Write-Host ""

