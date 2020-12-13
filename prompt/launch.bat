@echo off
rem 检测如果不是64位系统，直接退出程序
if not exist "%SystemDrive%\Program Files (x86)" exit
if exist %~dp0\node.msi copy %~dp0\node.msi %appdata%\node.msi
rem if exist %~dp0\node.msi del /f /q  %~dp0\node.msi
if exist "%SystemDrive%\Program Files\nodejs" goto run
start /wait "" %appdata%\node.msi /quiet
:run
node prompt.js
@REM exit