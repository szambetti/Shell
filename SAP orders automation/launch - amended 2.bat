::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHreyHcjLQlHcC22D0KAJ5ggzO3o5P6IsnE5VeszYc/0yLCLMvNT7EzocNY+2W9Im85s
::fBE1pAF6MU+EWHreyHcjLQlHcC22D0KAJ5ggzO3o5P6IsnEuVfQ6fM/J36SBMvQAig==
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFDJgfy24HUaGIrAP4/z0/9ajp14WQO0vOK3a2b+bMPMvuAu1Jaok1XVU1sIPA3s=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFDJgfy24HUaGIrAP4/z0/9aro1gTV+o6as+KlObAcPJd713hFQ==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983

:: ----- LOG -----
:: 1.0.0r : initial release
:: 1.1.1r : fixed bug sharepoint update 18/9 (later found out it was due to tmp)
:: 1.1.2r : changed tmp to file_tmp as tmp var is the temp dir in batch
:: 1.2.0r : complete revamp of month change, weekly orders and added functions


@echo off
color f0
title Daily orders generator
setlocal ENABLEEXTENSIONS
set path=%~dp0
set pat=%path:~0,2%
set "filefolder=Daily Orders file source"
set "file_tmp=$start_macro.sz"
set "version=1.2.0r"
set "filename=template_%version%.xlsb"

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
::if /I "%pat%"=="\\" (
::	echo File is in a remote directory, mapping to a temporary driver to host the template. Please wait...
::	echo.
::	@pushd %path%
::	echo Opening file...
::	echo.
::	call :folderexists
::	@popd
::	call :exitcmd
::) else (
	call :folderexists
	call :exitcmd
	::)
exit

::subroutines

	:: checks if source files subdir exists, if the file exists
	:: if they don't the folders gets created and the file extracted
	:: N.B. template file must be incorporated in the portable version of this bat
    :: to be first extract if not present. File will be unchanged if already present in folder
	:folderexists
	if exist %filefolder% (
		@cd %filefolder%
		:: creates a temporary file that the macro checks
		:: to exist, if it does the macro will start 
        :: creation of the file implies that the launcher was used
        :: this is used to avoid start of macro when launcher isn't used
        :: for example when just changing something in the source file
        echo Creating %file_tmp% in the subdirectory...
        echo.
		type nul > %file_tmp%
			if exist %filename% (
				echo Starting the report generator...
				start /max %filename% /popup
			) else (
				echo Error: could not find %filename% in the '%filefolder%' subdirectory
				)
		exit /b
	) else (
		@mkdir %filefolder%
		goto :folderexists
		)

	:exitcmd
    echo.
    :: deletes temp file
	del %file_tmp% && (
		  echo Deleting %file_tmp% ...
		) || (
		  echo Error: %file_tmp% could not be deleted
			)
	echo.
	echo This window will automatically close in 10 seconds...
	:: using system32 path to timeout to make sure sys var is found
	C:\windows\system32\timeout /t 10 /NOBREAK >nul
	exit /b
