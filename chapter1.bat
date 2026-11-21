@echo off
chcp 65001
set score_Yandex=0
set score_Selectel=0
set score_Timeweb=0

echo === Модуль выбора СУБД ===
echo.
echo Вопрос 1: Какой ожидаемый рост нагрузки?
echo 1. Менее 100 ГБ (кэширование, небольшие наборы)
echo 2. Более 1 ТБ (большие данные, аналитика)
echo 3. От 100 ГБ до 1 ТБ (стандартные реляционные данные)
choice /c 123 /n
if "%errorlevel%"=="3" set /a score_Timeweb+=10
if "%errorlevel%"=="2" set /a score_Selectel+=15
if "%errorlevel%"=="1" set /a score_Yandex+=10

echo.
echo Вопрос 2: Требуется ли молниеносный отклик для чтения?
echo 1. Да (кэширование, сессии)
echo 2. Нет (пакетная обработка)
choice /c 12 /n
if "%errorlevel%"=="1" set /a score_Yandex+=15
if "%errorlevel%"=="2" set /a score_Selectel+=5

echo.
set result=Timeweb Cloud
if %score_Selectel% gtr %score_Timeweb% set result=Selectel
if %score_Yandex% gtr %score_Selectel% if %score_Yandex% gtr %score_Timeweb% set result=Yandex Cloud
echo Рекомендация: %result%
set "RECOMMENDATION=result"
pause