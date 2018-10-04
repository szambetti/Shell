setlocal enableextensions
set path=%~dp0
set "deleted=%path%deleted.txt"
set BU=EPPC EPBP EPSO EPDS EPIP

for %%a in (%BU%) do (
	mkdir "%%a"
	for /r "%path%" %%i in (*%%a*.xlsx) do (
		set "name=%%~ni"
		if /i "%name%"=="*Direct*" (
		echo !i! >> %deleted%
 		del "%%i"
		) else (
			if /i "%name%"=="*LBU Proposal*" (
				echo !i! >> %deleted%
				del "%%i"
				) else (
					move "%%i" "%path%%%a"
					)
			)
		)
	)
)
pause










 	
)