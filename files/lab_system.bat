@echo off
chcp 65001
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
if "%choice%"=="5" exit /b

echo Неверный выбор. Нажмите любую клавишу...
pause >nul
goto menu

:run_all
cls
echo === Запуск всех модулей последовательно ===
echo.

echo --- Модуль 1: Выбор технологии ---
call chapter1.bat
set "result1=%RECOMMENDATION%"

echo.
echo --- Модуль 2: Инспекция кода ---
call chapter2.bat
set "result2=%REVIEWER_LEVEL%"

echo.
echo --- Модуль 3: Сравнительный анализ ---
call chapter3.bat
set "result3=%WINNER%"

echo.
echo === Итоговый отчёт системы ===
echo Модуль 1: Рекомендация по технологии: !result1!
echo Модуль 2: Уровень ревьюера: !result2!
echo Модуль 3: Победитель сравнительного анализа: !result3!
echo.

(
    echo === Итоговый отчёт системы ===
    echo Дата: %DATE% %TIME%
    echo.
    echo Модуль 1: Рекомендация по технологии: !result1!
    echo Модуль 2: Уровень ревьюера: !result2!
    echo Модуль 3: Победитель сравнительного анализа: !result3!
) > report.txt

echo Результаты сохранены в report.txt
pause
goto menu