## 1.Титульные данные ##
- Студент: Мамутин Максим Евгеньевич
- Группа: 3525П1ИН3
- Номер работы: 2
- Вариант: 4
## 2. Ссылку на репозиторий GitHub ##
-https://github.com/maksim51-wq/lab2-comprehensive--
## 3. Листинг каждого модуля с краткими комментариями к ключевым участкам кода ##
### 3.1. chapter1.bat ###
```
@echo off
chcp 65001

rem  chapter1.bat - Модуль выбора облачной платформы
rem  Кандидаты: Yandex Cloud, Selectel, Timeweb Cloud
rem  Вопросы о профиле проекта -> начисление баллов -> рекомендация

rem Счётчики баллов для каждого кандидата.
rem Важно: имена переменных без пробелов - в cmd пробелы в именах недопустимы.

set score_Yandex=0
set score_Selectel=0
set score_Timeweb=0

echo === Модуль выбора облачной платформы ===
echo.

rem --- Вопрос 1: ожидаемый рост нагрузки ---
echo Вопрос 1: Какой ожидаемый рост нагрузки?
echo 1. Менее 100 ГБ (кэширование, небольшие наборы)
echo 2. Более 1 ТБ (большие данные, аналитика)
echo 3. От 100 ГБ до 1 ТБ (стандартные реляционные данные)

rem choice возвращает номер выбранного пункта в errorlevel.
rem Сравнение только через "%errorlevel%"=="N" (а не if errorlevel==N).
choice /c 123 /n
if "%errorlevel%"=="3" set /a score_Timeweb+=10
if "%errorlevel%"=="2" set /a score_Selectel+=15
if "%errorlevel%"=="1" set /a score_Yandex+=10

echo.

rem --- Вопрос 2: требовательность к скорости чтения ---
echo Вопрос 2: Требуется ли молниеносный отклик для чтения?
echo 1. Да (кэширование, сессии)
echo 2. Нет (пакетная обработка)
choice /c 12 /n
if "%errorlevel%"=="1" set /a score_Yandex+=15
if "%errorlevel%"=="2" set /a score_Selectel+=5

echo.

rem --- Определение победителя ---
rem Без многострочных if (...) else (...) - они ненадёжны в UTF-8.
rem По умолчанию Timeweb Cloud, затем последовательно переопределяем.
set "result=Timeweb Cloud"
if %score_Selectel% gtr %score_Timeweb% set "result=Selectel"
if %score_Yandex% gtr %score_Selectel% if %score_Yandex% gtr %score_Timeweb% set "result=Yandex Cloud"

echo Рекомендация: %result%

rem Экспорт результата для lab_system.bat
set "RECOMMENDATION=%result%"

pause
```
### 3.2. chapter2.bat ###
```
@echo off
chcp 65001

rem  chapter2.bat - Модуль инспекции кода
rem  Три фрагмента Python-кода на облачную тематику.
rem  За верный ответ +1 к correct, иначе - сообщение об ошибке.

rem correct - число верных ответов, total - всего фрагментов
set correct=0
set total=3

echo === Модуль инспекции кода ===
echo.

rem --- Фрагмент 1: Yandex Cloud Object Storage ---
rem Дефект: файл открыт через open() без with/close() -> утечка ресурса
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
    rem Внутри блока используем rem, а не ::
    rem Правильный ответ - утечка ресурса (дескриптор файла не закрыт)
    echo Верно! Файл открыт без with/close - утечка дескриптора.
    set /a correct+=1
) else (
    echo Неверно. Правильный ответ: 1
)

echo.

rem --- Фрагмент 2: Selectel ---
rem Дефект: строка 23 перезаписывает status -> мёртвое присваивание
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
    rem Значение из строки 22 теряется - классическое мёртвое присваивание
    echo Верно! Строка 23 перезаписывает status, значение из строки 22 теряется.
    set /a correct+=1
) else (
    echo Неверно. Правильный ответ: 2
)

echo.

rem --- Фрагмент 3: Timeweb Cloud ---
rem Дефект: timeout = 3600 захардкожен -> магическое число
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
    rem 3600 - магическое число, должно быть вынесено в константу
    echo Верно! 3600 - магическое число, должно быть вынесено в константу.
    set /a correct+=1
) else (
    echo Неверно. Правильный ответ: 2
)

echo.

rem --- Итоговый отчёт ---
echo === Итоговый отчёт ===
echo Правильных ответов: %correct% из %total%
rem Процент точности (целочисленное деление)
set /a percentage=correct*100/total
echo Точность: %percentage%%%

rem Присвоение уровня ревьюера
set "REVIEWER_LEVEL=Junior Reviewer"
if %percentage% geq 50 set "REVIEWER_LEVEL=Middle Reviewer"
if %percentage% geq 80 set "REVIEWER_LEVEL=Senior Reviewer"
echo Уровень: %REVIEWER_LEVEL%

rem Экспорт результата для lab_system.bat
pause
```
### 3.3. chapter3.bat ###
```
@echo off
chcp 65001

rem  chapter3.bat - Модуль сравнительного анализа (WSM)
rem  Альтернативы: Yandex Cloud, Selectel, Timeweb Cloud
rem  Критерии: Стоимость владения, Масштабируемость, Простота миграции
rem  Формула: S = sum(W * X)

echo === Модуль сравнительного анализа облачных платформ ===
echo.

rem --- Ввод весов критериев ---
echo Назначьте веса критериям (сумма должна быть 100):
set /p w1="Вес критерия 1 (Стоимость владения): "
set /p w2="Вес критерия 2 (Масштабируемость): "
set /p w3="Вес критерия 3 (Простота миграции): "

rem Проверка: сумма весов должна быть ровно 100
set /a total_weight=w1+w2+w3
if %total_weight% neq 100 (
    echo Ошибка: сумма весов не равна 100!
    pause
    rem exit /b - корректный выход из bat (не закрывает окно cmd)
    exit /b
)

echo.

rem --- Оценки альтернатив по шкале 1-5 ---
echo Оцените альтернативы по шкале 1-5:

rem Yandex Cloud
echo --- Yandex Cloud ---
set /p y_1="Yandex Cloud по критерию 1: "
set /p y_2="Yandex Cloud по критерию 2: "
set /p y_3="Yandex Cloud по критерию 3: "

rem Selectel
echo --- Selectel ---
set /p s_1="Selectel по критерию 1: "
set /p s_2="Selectel по критерию 2: "
set /p s_3="Selectel по критерию 3: "

rem Timeweb Cloud
echo --- Timeweb Cloud ---
set /p t_1="Timeweb Cloud по критерию 1: "
set /p t_2="Timeweb Cloud по критерию 2: "
set /p t_3="Timeweb Cloud по критерию 3: "

rem --- Расчёт взвешенных сумм ---
rem S = w1*x1 + w2*x2 + w3*x3 для каждой альтернативы
set /a score_y=y_1*w1+y_2*w2+y_3*w3
set /a score_s=s_1*w1+s_2*w2+s_3*w3
set /a score_t=t_1*w1+t_2*w2+t_3*w3

echo.

rem --- Матрица решений ---
rem Символ | в echo экранируется как ^| иначе cmd примет его за оператор канала
echo === Матрица решений ===
echo Критерий            ^| Вес ^| Yandex Cloud ^| Selectel ^| Timeweb Cloud
echo Стоимость владения  ^| %w1%  ^| %y_1%           ^| %s_1%      ^| %t_1%
echo Масштабируемость    ^| %w2%  ^| %y_2%           ^| %s_2%      ^| %t_2%
echo Простота миграции   ^| %w3%  ^| %y_3%           ^| %s_3%      ^| %t_3%
echo ИТОГО               ^|      ^| %score_y%       ^| %score_s%  ^| %score_t%

rem --- Определение победителя ---
rem По умолчанию Timeweb Cloud, затем переопределяем по цепочке gtr
set "WINNER=Timeweb Cloud"
if %score_s% gtr %score_t% set "WINNER=Selectel"
if %score_y% gtr %score_s% if %score_y% gtr %score_t% set "WINNER=Yandex Cloud"

echo Победитель: %WINNER%

rem Экспорт результата для lab_system.bat
pause
```
### 3.4. lab_system.bat ###
```
@echo off
chcp 65001

rem  lab_system.bat - Главный файл
rem  Меню + запуск chapter1/2/3 + агрегация + report.txt


rem EnableDelayedExpansion нужен для !result1! внутри блока (...) > file,
rem иначе переменные подставятся до выполнения блока и будут пустыми.
setlocal EnableDelayedExpansion

:menu
cls
echo ========================================
echo   СИСТЕМА МОДЕЛИРОВАНИЯ ПРОЦЕССОВ РАЗРАБОТКИ ПО
echo ========================================
echo.
echo 1. Модуль выбора технологий (chapter1.bat)
echo 2. Модуль инспекции кода (chapter2.bat)
echo 3. Модуль сравнительного анализа (chapter3.bat)
echo 4. Запустить все модули последовательно
echo 5. Выход
echo.
set /p choice="Ваш выбор: "

rem call обязателен: без него управление не вернётся в меню после модуля
if "%choice%"=="1" (
    call chapter1.bat
    goto menu
)
if "%choice%"=="2" (
    call chapter2.bat
    goto menu
)
if "%choice%"=="3" (
    call chapter3.bat
    goto menu
)
if "%choice%"=="4" goto run_all
rem exit /b - выход только из этого bat
if "%choice%"=="5" exit /b

rem Обработка неверного ввода - возврат в меню
echo Неверный выбор. Нажмите любую клавишу...
pause >nul
goto menu

:run_all
cls
echo === Запуск всех модулей последовательно ===
echo.

rem --- Модуль 1 ---
rem chapter1.bat экспортирует переменную RECOMMENDATION
echo --- Модуль 1: Выбор технологии ---
call chapter1.bat
set "result1=%RECOMMENDATION%"

echo.

rem --- Модуль 2 ---
rem chapter2.bat экспортирует переменную REVIEWER_LEVEL
echo --- Модуль 2: Инспекция кода ---
call chapter2.bat
set "result2=%REVIEWER_LEVEL%"

echo.

rem --- Модуль 3 ---
rem chapter3.bat экспортирует переменную WINNER
echo --- Модуль 3: Сравнительный анализ ---
call chapter3.bat
set "result3=%WINNER%"

echo.

rem --- Итоговый отчёт на экран ---
rem Используем !var! из-за EnableDelayedExpansion
echo === Итоговый отчёт системы ===
echo Модуль 1: Рекомендация по технологии: !result1!
echo Модуль 2: Уровень ревьюера: !result2!
echo Модуль 3: Победитель сравнительного анализа: !result3!
echo.

rem --- Запись отчёта в файл ---
rem %~dp0 - путь к папке скрипта, чтобы report.txt всегда лежал рядом
(
    echo === Итоговый отчёт системы ===
    echo Дата: %DATE% %TIME%
    echo.
    echo Модуль 1: Рекомендация по технологии: !result1!
    echo Модуль 2: Уровень ревьюера: !result2!
    echo Модуль 3: Победитель сравнительного анализа: !result3!
) > "%~dp0report.txt"

echo Результаты сохранены в report.txt
pause
goto menu
```
## 4. Скриншоты работы каждого модуля в отдельности ##
### 4.1. Скриншот chapter1.bat ###
<img width="443" height="266" alt="screenshot-chapter1" src="https://github.com/user-attachments/assets/9593a656-2a1f-46aa-ac2c-5fe3ed7c257a" />
### 4.2. Скриншот chapter2.bat ###
<img width="582" height="733" alt="screenshot-chapter2" src="https://github.com/user-attachments/assets/ed3dccd2-9d73-425c-b753-a7845e26e204" />
### 4.3. Скриншот chapter3.bat ###
<img width="542" height="487" alt="screenshot-chapter3" src="https://github.com/user-attachments/assets/5c04cf48-5c2f-427d-a497-e1e14334b4b1" />
## 5. Скриншот работы главного файла lab_system.bat (главное меню) ##

## 6. Скриншот прохождения всех трёх модулей последовательно (пункт 4 главного меню) ##

## 7. Описание того, что получилось при запуске интегрированной системы ##
### 7.1. Какие диалоги и вопросы задавались в каждом модуле ###
Модуль 1 (chapter1.bat):
* Вопрос 1: ожидаемый рост нагрузки (менее 100 ГБ / более 1 ТБ / 100 ГБ–1 ТБ).
* Вопрос 2: требуется ли молниеносный отклик для чтения (да / нет).

Модуль 2 (chapter2.bat):
* Фрагмент 1 (Yandex Cloud Object Storage) — выбор типа дефекта из 3 вариантов.
* Фрагмент 2 (Selectel) — выбор типа дефекта из 3 вариантов.
* Фрагмент 3 (Timeweb Cloud) — выбор типа дефекта из 3 вариантов.

Модуль 3 (chapter3.bat):
* Ввод трёх весов критериев (Стоимость владения, Масштабируемость, Простота миграции) с проверкой суммы = 100.
* Ввод девяти оценок по шкале 1–5 (3 альтернативы × 3 критерия).

### 7.2. Какие рекомендации были сформированы ###
* Модуль 1: рекомендация - Yandex Cloud (рост нагрузки менее 100 ГБ + нужен быстрый отклик чтения).
* Модуль 2: уровень ревьюера - Senior Reviewer (3 из 3 верных, точность 100%).
* Модуль 3: победитель - Yandex Cloud при весах 40 / 35 / 25 и оценках Yandex Cloud (5, 5, 4), Selectel (4, 4, 4), Timeweb Cloud (5, 3, 3).
### 7.3. Итоговый отчёт системы ###
```
=== Итоговый отчёт системы ===
Модуль 1: Рекомендация по технологии: result
Модуль 2: Уровень ревьюера: Senior Reviewer
Модуль 3: Победитель сравнительного анализа: Yandex Cloud
```
### 7.4. Впечатления от работы с системой ###
Мне понравилась писать эти модули, хочеться попробовать что нибудь ещё поделать с bat файлами
## 8. Инструкция по запуску системы для другого пользователя ##
1. Скачать из репозитория все четыре файла: chapter1.bat, chapter2.bat, chapter3.bat, lab_system.bat — в одну папку.
2. Убедиться, что файлы сохранены в кодировке UTF-8 (все скрипты начинаются с chcp 65001).
3. Двойной клик по lab_system.bat.
В главном меню выбрать нужный пункт:

1 - только модуль выбора технологий;

2 - только модуль инспекции кода;

3 - только модуль сравнительного анализа;

4 - все три модуля последовательно + итоговый отчёт;

5 - выход.

5. Для полной проверки выбрать пункт 4.
После прохождения всех модулей в папке появится файл report.txt с итоговым отчётом.
6. Для выхода из меню — пункт 5.
