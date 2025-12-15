# Скрипт для создания изменений в feature ветке для PR
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Создание изменений для Pull Request" -ForegroundColor Cyan
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

# Добавление файла CHANGELOG.md (если еще не добавлен)
if (-not (Test-Path "CHANGELOG.md")) {
    Write-Host "Создание файла CHANGELOG.md..." -ForegroundColor Yellow
    @"
# Changelog

## [Unreleased]

### Added
- Feature branch for improvements
- This file to track changes

### Changed
- Created feature/improvements branch for pull request demonstration
"@ | Out-File -FilePath "CHANGELOG.md" -Encoding UTF8
}

# Добавление всех изменений
Write-Host "Добавление изменений..." -ForegroundColor Yellow
git add .

# Создание коммита
Write-Host "Создание коммита..." -ForegroundColor Yellow
git commit -m "Add CHANGELOG.md and update README for PR demonstration"

# Загрузка ветки на GitHub
Write-Host ""
Write-Host "Загрузка ветки на GitHub..." -ForegroundColor Yellow
git push -u origin feature/improvements

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Успешно! Изменения загружены." -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Теперь вы можете создать Pull Request:" -ForegroundColor Cyan
    Write-Host "1. Перейдите на https://github.com/doboleshev/diary-app" -ForegroundColor White
    Write-Host "2. Нажмите 'Compare & pull request'" -ForegroundColor White
    Write-Host "3. Заполните описание" -ForegroundColor White
    Write-Host "4. Нажмите 'Create pull request'" -ForegroundColor White
} else {
    Write-Host ""
    Write-Host "Ошибка при загрузке. Проверьте подключение к GitHub." -ForegroundColor Red
}

Write-Host ""

