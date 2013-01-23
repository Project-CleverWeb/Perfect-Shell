@echo off

rem Perfect-Shell vars
set pshell_ver="1.0"
set pshell_keyword="pshell"
set pshell_errors="none"


rem get the OS architecture
set os_arc="64"
if not exist "%systemdrive%\Program Files (x86)" set os_arc="32"

rem check for admin rights here
rem check for git here

cls
echo.
echo.
echo            /--------------------------------------------------------\
echo.
echo                              Welcome to Perfect-Shell
echo.
echo                      Version: 1.0
echo                      Requirements:
echo                      Errors: %pshell_errors%
echo.
echo            \--------------------------------------------------------/
echo.
echo.
CHOICE /C YN /M Do you wish to start installation? Yes (y), No (n) 
IF errorlevel 2 goto fail
IF errorlevel 1 goto start


:fail
cls
echo.
echo.
echo            /--------------------------------------------------------\
echo.
echo                               Installation Aborted!
echo.
echo                      Errors: %pshell_errors%
echo.
echo            \--------------------------------------------------------/
echo.
echo.
echo Exiting...
@ping 1.1.1.1 -n 1 -w 5000 > nul
exit

:start
rem ask for custom keyword here
echo Warning: Only set this if you know what you are doing!
CHOICE /C YN /M Do you wish to set your own start command? Yes (y), No (n) 
IF errorlevel 2 goto install
IF errorlevel 1 goto set_keyword

:set_keyword
echo What command would you like to type to start Perfect-Shell?
echo Keep in mind, this cannot be an existing command.
set /p pshell_keyword="What command would you like to type to start Perfect-Shell?"


:install
CHOICE /C YN /M Last Chance: Are you sure you wish to install? Yes (y), No (n)
IF errorlevel 2 goto fail
rem (install)

:success
cls
echo.
echo.
echo            /--------------------------------------------------------\
echo.
echo                      Thank you for installing Perfect-Shell!
echo.
echo                      Activation Keyword: pshell (default)
echo                      Install Path: meh/pshell.bat
echo                      Errors: %pshell_errors%
echo.
echo            \--------------------------------------------------------/
echo.
echo.
echo Press any key to exit
pause>nul
exit

rem default length of cmd window 
rem  --------------------------------------------------------------------------------