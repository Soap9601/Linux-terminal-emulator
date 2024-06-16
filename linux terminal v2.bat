@echo off
setlocal enabledelayedexpansion

:: Enable ANSI escape codes for color and cursor control
for /f "delims=" %%i in ('echo prompt $E ^| cmd') do set "ESC=%%i"
echo %ESC%[?25l
echo %ESC%[?1049h
echo %ESC%[H%ESC%[J

:: Set the color codes
set "COLOR_BLUE=%ESC%[34m"
set "COLOR_RESET=%ESC%[0m"

:main
cls
color 0A
echo.
echo ====================================================
echo             Welcome to Linux Terminal Simulator
echo ====================================================
echo.
echo Type help to view all commands
echo.

:prompt
set /p command=%COLOR_BLUE%$USER@simulator:$PWD%COLOR_RESET%^$ 

:: Convert Linux commands to Windows commands
set "win_command="
if /i "%command%"=="ls" set "win_command=dir"
if /i "%command%"=="pwd" set "win_command=cd"
if /i "%command%"=="clear" set "win_command=cls"
if /i "%command%"=="mkdir" set "win_command=mkdir"
if /i "%command%"=="rmdir" set "win_command=rmdir /s /q"
if /i "%command%"=="echo" set "win_command=echo"
if /i "%command%"=="cat" set "win_command=type"
if /i "%command%"=="find" set "win_command=findstr"
if /i "%command%"=="whoami" set "win_command=whoami"
if /i "%command%"=="cd" set "win_command=cd"
if /i "%command%"=="date" set "win_command=date /t"
if /i "%command%"=="uname" set "win_command=ver"
if /i "%command%"=="env" set "win_command=set"
if /i "%command%"=="printenv" set "win_command=set"
if /i "%command%"=="systeminfo" set "win_command=systeminfo"
if /i "%command%"=="wifi-passwords" set "win_command=netsh wlan show profiles"
if /i "%command%"=="ip-addresses" set "win_command=ipconfig"
if /i "%command%"=="exit" exit /b
if /i "%command%"=="logout" exit /b
if /i "%command%"=="help" goto help

:: Check if the command is supported
if not defined win_command (
    echo Command not supported.
    pause
    goto main
)

:: Execute the Windows command
%win_command%

pause
goto main

:help
cls
echo.
echo ====================================================
echo                      Help Menu
echo ====================================================
echo.
echo ls            - List directory contents (dir)
echo pwd           - Print working directory (cd)
echo clear         - Clear the terminal screen (cls)
echo mkdir         - Make directories (mkdir)
echo rmdir         - Remove directories (rmdir /s /q)
echo echo          - Display a line of text (echo)
echo cat           - Concatenate and display files (type)
echo find          - Search for files (findstr)
echo whoami        - Display current user (whoami)
echo cd            - Change directory (cd)
echo date          - Display or set the date (date /t)
echo uname         - Print system information (ver)
echo env           - Print environment variables (set)
echo printenv      - Print environment variables (set)
echo systeminfo    - Display system information (systeminfo)
echo wifi-passwords- Show Wi-Fi passwords (netsh wlan show profiles)
echo ip-addresses  - Show IP addresses (ipconfig)
echo exit          - Exit the terminal (exit)
echo logout        - Exit the terminal (exit)
echo help          - Display this help menu
echo.
pause
goto main
