@echo off
title Daily orders generator
setlocal ENABLEEXTENSIONS
set path=%~dp0
set pat=%path:~0,2%
set "filefolder=Source files"
set "tmp=~daily_orders.tmp"
set "version=1.0 R"
set "filename=template [%version%].xlsb"

:: clears remote directory issue
cls

:: main
echo.
echo     - Daily orders report generator -
echo            - Version: %version% - 
echo.
echo Directory where this launcher is hosted: %path%
echo.
echo Looking for %filename% in the '%filefolder%' subdirectory...
echo.
::if file is hosted in a directory in a network drive, need to map a temp driver to launch file
if /I "%pat%"=="\\" (
	echo File is in a remote directory, mapping to a temporary driver to host the template. Please wait...
	echo.
	@pushd %path%
	echo Opening file...
	echo.
	call :folderexists
	@popd
	call :exitcmd
) else (
	call :folderexists
	call :exitcmd
	)
exit

::subroutines

	:: checks if source files subdir exists, if the file exists
	:: if they don't the folders gets created and the file extracted
	:: N.B. template file must be incorporated in the portable version of this bat
	:folderexists
	if exist %filefolder% (
		@cd %filefolder%
		:: creates a temporary file that the macro checks
		:: if file exists, macro will start (as it means the laucnher was used)
		:: if the file doesn't exist then the macro won't start 
		@type nul > %tmp%
			:fileexists
			if exist %filename% (
				echo Starting the report generator...
				start /max %filename% /popup
			) else (
				echo Could not find %filename% in the '%filefolder%' subdirectory
				echo Extracting %% to the '%filefolder%' subdirectory
				echo.
				goto :fileexists
				)
		exit /b
	) else (
		@mkdir %filefolder%
		goto :folderexists
		)

	:exitcmd
	echo.
	echo This window will automatically close in 10 seconds...
	:: using system32 path to timeout to make sure sys var is found
	C:\windows\system32\timeout /t 10 /NOBREAK >nul
	:: deletes temp file
	@del %temp% && (
		  echo Deleting %temp% ...
		) || (
		  echo Error: %temp% could not be deleted
			)
	exit /b
