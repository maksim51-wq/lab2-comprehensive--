@echo off
chcp 65001
set correct=0
set total=3

echo === Модуль инспекции кода ===
echo.
echo Фрагмент 1 (работа с Yandex Cloud Object Storage):
echo 10: def upload_file(client, bucket, key, path):
echo 11:     file = open(path, "rb")
echo 12:     client.put_object(Bucket=bucket, Key=key, Body=file)
echo 13:     return True
echo.
echo Какой дефект здесь скрыт?
echo 1. Утечка ресурса (файл не закрыт)
echo 2. Мёртвое присваивание
echo 3. Магическое число
choice /c 123 /n
if "%errorlevel%"=="1" (
    echo Верно! Файл открыт без with/close — утечка дескриптора.
    set /a correct+=1
) else (
    echo Неверно. Правильный ответ: 1
)

echo.
echo Фрагмент 2 (работа с Selectel):
echo 20: def get_server_status(api, server_id):
echo 21:     resp = api.get(f"/servers/{server_id}")
echo 22:     status = resp.json()["status"]
echo 23:     status = "unknown"
echo 24:     return status
echo.
echo Какой дефект здесь скрыт?
echo 1. Отсутствие обработки ошибок
echo 2. Мёртвое присваивание
echo 3. Неинициализированная переменная
choice /c 123 /n
if "%errorlevel%"=="2" (
    echo Верно! Строка 23 перезаписывает status, значение из строки 22 теряется.
    set /a correct+=1
) else (
    echo Неверно. Правильный ответ: 2
)

echo.
echo Фрагмент 3 (работа с Timeweb Cloud):
echo 30: def create_backup(api, server_id):
echo 31:     timeout = 3600
echo 32:     api.post(f"/servers/{server_id}/backup", timeout=timeout)
echo 33:     return "ok"
echo.
echo Какой дефект здесь скрыт?
echo 1. Утечка ресурса
echo 2. Магическое число (3600)
echo 3. Недостижимый код
choice /c 123 /n
if "%errorlevel%"=="2" (
    echo Верно! 3600 — магическое число, должно быть вынесено в константу.
    set /a correct+=1
) else (
    echo Неверно. Правильный ответ: 2
)

echo.
echo === Итоговый отчёт ===
echo Правильных ответов: %correct% из %total%
set /a percentage=correct*100/total
echo Точность: %percentage%%%

if %percentage% geq 80 (
    echo Уровень: Senior Reviewer
) else if %percentage% geq 50 (
    echo Уровень: Middle Reviewer
) else (
    echo Уровень: Junior Reviewer
)
if %percentage% geq 80 set "REVIEWER_LEVEL=Senior Reviewer"
if %percentage% geq 50 if %percentage% lss 80 set "REVIEWER_LEVEL=Middle Reviewer"
if %percentage% lss 50 set "REVIEWER_LEVEL=Junior Reviewer"

pause