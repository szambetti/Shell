@echo OFF
SETLOCAL ENABLEDELAYEDEXPANSION
set "filepath=%~dp0"
set "output=%filepath%\output.txt"

echo.
echo Working...
echo.
:: recursivelty stores last modified info of files and folders
for /R %filepath% %%X in (*) do (
   set "filename=%%~nxX"
   set "lastmodified=%%~tX"
   @echo !filename!: !lastmodified! >> %output%   
   )
   
echo Finished
echo.
pause