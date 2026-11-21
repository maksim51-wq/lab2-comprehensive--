@echo off
chcp 65001
echo === Модуль сравнительного анализа облачных платформ ===
echo.
echo Назначьте веса критериям (сумма должна быть 100):
set /p w1="Вес критерия 1 (Стоимость владения): "
set /p w2="Вес критерия 2 (Масштабируемость): "
set /p w3="Вес критерия 3 (Простота миграции): "

set /a total_weight=w1+w2+w3
if %total_weight% neq 100 (
    echo Ошибка: сумма весов не равна 100!
    pause
    exit
)

echo.
echo Оцените альтернативы по шкале 1-5:
echo --- Yandex Cloud ---
set /p y_1="Yandex Cloud по критерию 1: "
set /p y_2="Yandex Cloud по критерию 2: "
set /p y_3="Yandex Cloud по критерию 3: "
echo --- Selectel ---
set /p s_1="Selectel по критерию 1: "
set /p s_2="Selectel по критерию 2: "
set /p s_3="Selectel по критерию 3: "
echo --- Timeweb Cloud ---
set /p t_1="Timeweb Cloud по критерию 1: "
set /p t_2="Timeweb Cloud по критерию 2: "
set /p t_3="Timeweb Cloud по критерию 3: "

set /a score_y=y_1*w1+y_2*w2+y_3*w3
set /a score_s=s_1*w1+s_2*w2+s_3*w3
set /a score_t=t_1*w1+t_2*w2+t_3*w3

echo.
echo === Матрица решений ===
echo Критерий            ^| Вес ^| Yandex Cloud ^| Selectel ^| Timeweb Cloud
echo Стоимость владения  ^| %w1%  ^| %y_1%           ^| %s_1%      ^| %t_1%
echo Масштабируемость    ^| %w2%  ^| %y_2%           ^| %s_2%      ^| %t_2%
echo Простота миграции   ^| %w3%  ^| %y_3%           ^| %s_3%      ^| %t_3%
echo ИТОГО               ^|      ^| %score_y%       ^| %score_s%  ^| %score_t%

if %score_y% gtr %score_s% if %score_y% gtr %score_t% echo Победитель: Yandex Cloud
if %score_s% gtr %score_y% if %score_s% gtr %score_t% echo Победитель: Selectel
if %score_t% gtr %score_y% if %score_t% gtr %score_s% echo Победитель: Timeweb Cloud

if %score_y% gtr %score_s% if %score_y% gtr %score_t% set "WINNER=Yandex Cloud"
if %score_s% gtr %score_y% if %score_s% gtr %score_t% set "WINNER=Selectel"
if %score_t% gtr %score_y% if %score_t% gtr %score_s% set "WINNER=Timeweb Cloud"

pause