@echo off
TITLE Daily orders generator
SETLOCAL ENABLEEXTENSIONS
SET "filename=template.xlsb"
SET path=%~dp0
SET pat=%path:~0,2%
SET "filefolder=Template"

rem ---
cls
echo.
echo     - Daily orders report generator -
echo.
echo Directory where this launcher is hosted: %path%
echo.
echo Looking for %filename% in the '%filefolder%' subdirectory...
echo.
if /I "%pat%"=="\\" (
	echo File is in a remote directory, mapping to a temporary driver to host the template. Please wait...
	echo.
	@pushd %path%
	echo Opening file...
	echo.
	call :checkname
	@popd
	call :exitcmd
) else (
	call :checkname
	call :exitcmd
)
exit

:checkname
if exist %filefolder% (
	@cd %filefolder%
		if exist %filename% (
			echo Starting the report generator...
			start /max %filename% /popup
		) else (
			echo Error: Could not find %filename% in the '%filefolder%' subdirectory, please check the instructions...
			)
		exit /b
) else (
	@mkdir Template
	goto :checkname
)

:exitcmd
echo.
echo This window will automatically close in 10 seconds...
rem using system32 path to timeout to make suresys var is found
C:\windows\system32\timeout /t 10 /NOBREAK >nul
exit /b
