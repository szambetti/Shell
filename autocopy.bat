@echo off

Title AUTOCOPY FILE FOR ALL REGIONS
echo.
:insert
set /p "UserInputFile=Specify only file name to be copied > "
set /p "UserInputExtension=Specify its extension > "

if not exist "%UserInputFile%.%UserInputExtension%" (
 echo.
 echo File or Extensions are wrong! Please type them in again...
 echo.
 goto :insert
) else (
 goto :copy
)

:copy

rem Setting Regions Array
 
set regions=APAC CA CN DE IN IT LATAM MEA NEU SEU US
set first_region=APAC
if exist %UserInputFile%_%first_region%.%UserInputExtension% (
	for %%a in (%regions%) do ( 
	@echo on
	copy "%UserInputFile%.%UserInputExtension%" "%UserInputFile%_%%a.%UserInputExtension%"
)
) else (
echo File already exists, will not copy.
)

Rem Completion
cls
echo Autocopy completed.
pause