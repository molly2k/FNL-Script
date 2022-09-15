@echo off
REM 
REM Fortnite Launcher & Game Boost v2.1 - Fortnite Launching Script
REM 

if "%1"=="import" goto :argImport
if "%1"=="" goto :argFAIL
if "%1"=="open" goto :open
if "%1"=="/?" goto :info
if "%1"=="cleanup" goto :cleanup
if "%1"=="remove" goto :remove


:argImport
call :configCHECK
if "%2"=="Fortnite" (goto :argImportFN) else (goto :argFAIL)
:NotImported
echo. [Script]: Game is Not Imported...
echo. Help: FNL [/?]
goto :exit

:argImportFN
set FortnitePath=%3
if exist %FortnitePath%\FortniteClient-Win64-Shipping.exe (goto :ImportFNPASS) else (goto :NotExist)

:ImportFNPASS
echo.
md %HomePath%\.FNL\config > nul 2>&1
echo @echo off > %HomePath%\.FNL\config\config.bat
echo %FortnitePath%\FortniteClient-Win64-Shipping.exe >> %HomePath%\.FNL\config\config.bat
echo. [Script] Successfully Imported Fortnite
echo.
goto :exit

:cleanup
echo. [Script]: Cleaning up Launcher...
set cnt=0
cd %HomePath%\.FNL\logs\
for /f %%A in ('dir ^| find "File(s)"') do set cnt=%%A
del /s /q %HomePath%\.FNL\logs\*.log > nul 2>&1
cd %HomePath%
echo. [Script]: INFO: Removed %cnt% Files (~%cnt% KB)
echo.
goto :exit

:argFAIL
echo.
echo. Wrong Command Syntax
echo. Help: FNL [/?]
echo.
goto :exit

:open
call :configCHECK
if "%2"=="Fortnite" (goto :openFN) else (goto :argFAIL)

:openFN
if "%3"=="boost" (goto :openFNB)
if exist %HomePath%\.FNL\config\config.bat (goto :configNORMAL) else (goto :NotImported)

:openFNB
if exist %HomePath%\.FNL\config\config.bat (goto :configBOOST) else (goto :NotImported)

:LaunchScript
md %HomePath%\.FNL\logs > nul 2>&1
set nazwa=%time:~0,2%%time:~3,2%%time:~6,2%_%date:~-10,2%%date:~-7,2%%date:~-4,4%
echo [%nazwa%] ** STARTING LAUNCH SCRIPT ** >%HomePath%\.FNL\logs\"%nazwa%.log"
echo. [Launcher]: Opening Fortnite...
timeout /t 2 /nobreak > nul
call %HomePath%\.FNL\config\config.bat
timeout /t 3 /nobreak > nul
echo. [Script]: INFO: All Done...
set nazwa1=%time:~0,2%%time:~3,2%%time:~6,2%_%date:~-10,2%%date:~-7,2%%date:~-4,4%
echo [%nazwa1%] ** ENDING LAUNCH SCRIPT ** >>%HomePath%\.FNL\logs\"%nazwa%.log"
timeout /t 1 /nobreak > nul
echo. [Script]: INFO: Closing Script...
timeout /t 1 /nobreak > nul
goto :exit

:LaunchScriptBoost
md %HomePath%\.FNL\logs > nul 2>&1
set nazwa=%time:~0,2%%time:~3,2%%time:~6,2%_%date:~-10,2%%date:~-7,2%%date:~-4,4%
echo [%nazwa%] ** STARTING LAUNCH SCRIPT ** >%HomePath%\.FNL\logs\"%nazwa%.log"
echo. [Script]: Setting GameUserSettings to READ-ONLY...
attrib +r %localAppData%\FortniteGame\Saved\Config\WindowsClient\gameusersettings.ini
timeout /t 2 /nobreak > nul
echo. [GameBoost]: Cleaning Cache...
timeout /t 2 /nobreak > nul
del /s /f /q c:\windows\temp\*.* > nul 2>&1
rd /s /q c:\windows\temp > nul 2>&1
md c:\windows\temp > nul 2>&1
del /s /f /q C:\WINDOWS\Prefetch > nul 2>&1
del /s /f /q %temp%\*.* > nul 2>&1
rd /s /q %temp% > nul 2>&1
md %temp% > nul 2>&1
deltree /y c:\windows\tempor~1 > nul 2>&1
deltree /y c:\windows\temp > nul 2>&1
deltree /y c:\windows\tmp > nul 2>&1
deltree /y c:\windows\ff*.tmp > nul 2>&1
deltree /y c:\windows\history > nul 2>&1
deltree /y c:\windows\cookies > nul 2>&1
deltree /y c:\windows\recent > nul 2>&1
deltree /y c:\windows\spool\printers > nul 2>&1
echo. [GameBoost]: Cleaning Fortnite Cache...
timeout /t 2 /nobreak > nul
forfiles -p "%localAppData%\FortniteGame" -s -m *.* /C "cmd /c del @path /Q" > nul 2>&1
echo. [Launcher]: Opening Fortnite...
timeout /t 2 /nobreak > nul
call %HomePath%\.FNL\config\config.bat
echo. [Launcher]: Waiting for Full Game Opens...
timeout /t 60 /nobreak > nul
echo. [GameBoost]: Turning Off Useless Services/Programs...
timeout /t 2 /nobreak > nul
sc config CryptSvc start= disabled > nul 2>&1
sc stop CryptSvc > nul 2>&1
sc stop NVDisplay.ContainerLocalSystem > nul 2>&1
taskkill /IM EpicGamesLauncher.exe /f > nul 2>&1
taskkill /IM TextInputHost.exe /f > nul 2>&1
for /f "tokens=2 delims== " %%A in ('find "TurnOffTeams=" %HomePath%\.FNL\config\config.ini') do set teams=%%A
if %teams%==True (taskkill /IM MicrosoftTeams.exe /f) > nul 2>&1
taskkill /IM OneDrive.exe /f > nul 2>&1
sc stop XboxNetApiSvc > nul 2>&1
sc stop XboxGipSvc > nul 2>&1
sc stop XblGameSave > nul 2>&1
sc stop XblAuthManager > nul 2>&1
timeout /t 3 /nobreak > nul
echo. [Script]: INFO: All Done...
set nazwa1=%time:~0,2%%time:~3,2%%time:~6,2%_%date:~-10,2%%date:~-7,2%%date:~-4,4%
echo [%nazwa1%] ** ENDING LAUNCH SCRIPT ** >>%HomePath%\.FNL\logs\"%nazwa%.log"
timeout /t 1 /nobreak > nul
echo. [Script]: INFO: Closing Script...
timeout /t 1 /nobreak > nul
goto :exit


:remove
call :configCHECK
if not exist %HomePath%\.FNL\config\config.bat (goto :NotImported)
if "%2"=="Fortnite" (goto :removeFN) else (goto :argFAIL)

:removeFN
del /q %HomePath%\.FNL\config\config.bat
echo. [Script]: INFO: Successfully Removed Fortnite!
goto :exit

:NotExist
echo.
echo. [Script]: INFO: Undefined Path...
echo. [Script]: INFO: Fortnite isn't installed on this path!
echo. Help: 
echo. fnl [/?]
goto :exit
:info
echo.
echo. usage: fnl {import,open,cleanup,remove}
echo         fnl [open] [game] [optional arguments]
echo.
echo.
echo. Optional Arguments:
echo.   {boost}
echo.      [boost]           Game Boost
echo.
echo.
echo.
echo. Commands:
echo.   {import,open,cleanup,remove}
echo.      import            Import Fortnite Game
echo.      open              Launch Fortnite Game
echo.      cleanup           Remove logs, temporary files
echo.      remove            Remove saved Fortnite Path
echo.
goto :exit

:Update
set version=v2.1
set czas=%time:~0,2%%time:~3,2%%time:~6,2%_%date:~-10,2%%date:~-7,2%%date:~-4,4%
echo [%czas%] ** AUTO CHECK UPDATE ** >%HomePath%\.FNL\logs\"%czas%.log"
powershell -c "Invoke-WebRequest -Uri 'https://docs.google.com/document/d/11z7zo1LBINMJ8TohhcSZLF4fKm_NVT0OSJiZglYhoZs/export?format=txt' -OutFile %HOMEPATH%\AppData\Local\Temp\FNLVERSION.txt
findstr /m "%version%" %HOMEPATH%\AppData\Local\Temp\FNLVERSION.txt > nul 2>&1
if %errorlevel%==0 (goto :LaunchScript) else (goto :UpdateINFO)

:UpdateINFO
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo. [Update]: INFO: AVAILABLE IS NEW VERSION!
echo. [Update]: INFO: DOWNLOAD ON MY DISCORD
echo. [Update]: INFO: DISCORD.IO/MOLLY2K
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo.
timeout /t 3 /nobreak > nul
goto :LaunchScript

:UpdateBOOST
set version=v2.1
set czas=%time:~0,2%%time:~3,2%%time:~6,2%_%date:~-10,2%%date:~-7,2%%date:~-4,4%
echo [%czas%] ** AUTO CHECK UPDATE ** >%HomePath%\.FNL\logs\"%czas%.log"
powershell -c "Invoke-WebRequest -Uri 'https://docs.google.com/document/d/11z7zo1LBINMJ8TohhcSZLF4fKm_NVT0OSJiZglYhoZs/export?format=txt' -OutFile %HOMEPATH%\AppData\Local\Temp\FNLVERSION.txt
findstr /m "%version%" %HOMEPATH%\AppData\Local\Temp\FNLVERSION.txt > nul 2>&1
if not %errorlevel%==0 (goto :UpdateINFOBOOST) else (goto :LaunchScriptBoost)


:UpdateINFOBOOST
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo. [Update]: INFO: AVAILABLE IS NEW VERSION!
echo. [Update]: INFO: DOWNLOAD ON MY DISCORD
echo. [Update]: INFO: DISCORD.IO/MOLLY2K
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo.
timeout /t 3 /nobreak > nul
goto :LaunchScriptBoost

:configGEN1
echo [Launcher] > %HomePath%\.FNL\config\config.ini
echo TurnOffTeams=True >> %HomePath%\.FNL\config\config.ini
echo. >> %HomePath%\.FNL\config\config.ini
echo [Script] >> %HomePath%\.FNL\config\config.ini
echo AutoUpdateCheck=True >> %HomePath%\.FNL\config\config.ini
fnl %1 %2 %3


:configBOOST
for /f "tokens=2 delims== " %%A in ('find "AutoUpdateCheck=" %HomePath%\.FNL\config\config.ini') do set Update=%%A
if %Update%==True (goto :UpdateBOOST) else (goto :LaunchScriptBoost)
:configNORMAL
for /f "tokens=2 delims== " %%B in ('find "AutoUpdateCheck=" %HomePath%\.FNL\config\config.ini') do set Update=%%B
if %Update%==True (goto :Update) else (goto :LaunchScript)

:configCHECK
if not exist %HomePath%\.FNL\config\config.ini (goto :ConfigGEN1)
:exit
