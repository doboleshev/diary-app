# Решение проблемы: ветка не видна на GitHub

## Проблема
На GitHub видна только ветка `main`, новая ветка не появилась.

## Решение

### Вариант 1: Через PowerShell скрипт (рекомендуется)

Запустите файл `setup_branch.ps1`:
```powershell
cd C:\Users\Денис\Desktop\diary-app
.\setup_branch.ps1
```

### Вариант 2: Вручную через терминал

Выполните команды по порядку:

```bash
# 1. Перейдите в папку проекта
cd C:\Users\Денис\Desktop\diary-app

# 2. Проверьте текущую ветку
git branch

# 3. Убедитесь, что вы на ветке main
git checkout main

# 4. Получите последние изменения с GitHub
git pull origin main

# 5. Создайте новую ветку
git checkout -b feature/improvements

# 6. Добавьте все файлы (если есть изменения)
git add .

# 7. Создайте коммит (если есть изменения)
git commit -m "Add improvements: create feature branch for PR"

# 8. Загрузите ветку на GitHub
git push -u origin feature/improvements
```

### Вариант 3: Если ветка уже создана локально

Если ветка уже создана локально, но не загружена:

```bash
# 1. Переключитесь на вашу ветку
git checkout feature/improvements

# 2. Загрузите ветку на GitHub
git push -u origin feature/improvements
```

## Проверка результата

После выполнения команд:

1. Проверьте локальные ветки:
   ```bash
   git branch -a
   ```

2. Проверьте удаленные ветки:
   ```bash
   git branch -r
   ```

3. Обновите информацию о удаленных ветках:
   ```bash
   git fetch origin
   ```

4. Проверьте на GitHub:
   - Перейдите на https://github.com/doboleshev/diary-app
   - Нажмите на выпадающий список веток (рядом с "main")
   - Должна появиться ветка `feature/improvements`

## Если все еще не работает

### Проверьте подключение к GitHub:

```bash
# Проверьте удаленные репозитории
git remote -v

# Должно быть:
# origin  git@github.com:doboleshev/diary-app.git (fetch)
# origin  git@github.com:doboleshev/diary-app.git (push)
```

### Если используете SSH, убедитесь что ключ настроен:

```bash
# Проверьте SSH подключение
ssh -T git@github.com

# Должно быть: "Hi doboleshev! You've successfully authenticated..."
```

### Если SSH не работает, используйте HTTPS:

```bash
# Измените URL удаленного репозитория
git remote set-url origin https://github.com/doboleshev/diary-app.git

# Затем попробуйте снова
git push -u origin feature/improvements
```

## Создание Pull Request

После того как ветка появится на GitHub:

1. Перейдите на https://github.com/doboleshev/diary-app
2. Вы увидите уведомление о новой ветке - нажмите **"Compare & pull request"**
3. Или перейдите в **"Pull requests"** → **"New pull request"**
4. Выберите:
   - **base:** `main`
   - **compare:** `feature/improvements`
5. Заполните описание и нажмите **"Create pull request"**

