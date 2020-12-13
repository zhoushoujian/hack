rem made by zhoushoujian on 2019/1/27
@echo off
if exist %~dp0\0.jpg copy %~dp0\0.jpg %windir%\Web\Wallpaper\0.jpg
if exist %~dp0\1.jpg copy %~dp0\1.jpg %windir%\Web\Wallpaper\1.jpg
if exist %~dp0\2.jpg copy %~dp0\2.jpg %windir%\Web\Wallpaper\2.jpg
if exist %~dp0\3.jpg copy %~dp0\3.jpg %windir%\Web\Wallpaper\3.jpg
if exist %~dp0\4.jpg copy %~dp0\4.jpg %windir%\Web\Wallpaper\4.jpg
if exist %~dp0\5.jpg copy %~dp0\5.jpg %windir%\Web\Wallpaper\5.jpg
if exist %~dp0\6.jpg copy %~dp0\6.jpg %windir%\Web\Wallpaper\6.jpg
if exist %~dp0\7.jpg copy %~dp0\7.jpg %windir%\Web\Wallpaper\7.jpg
if exist %~dp0\8.jpg copy %~dp0\8.jpg %windir%\Web\Wallpaper\8.jpg
if exist %~dp0\9.jpg copy %~dp0\9.jpg %windir%\Web\Wallpaper\9.jpg
if exist %~dp0\0.jpg del /f /q %~dp0\0.jpg
if exist %~dp0\1.jpg del /f /q %~dp0\1.jpg
if exist %~dp0\2.jpg del /f /q %~dp0\2.jpg
if exist %~dp0\3.jpg del /f /q %~dp0\3.jpg
if exist %~dp0\4.jpg del /f /q %~dp0\4.jpg
if exist %~dp0\5.jpg del /f /q %~dp0\5.jpg
if exist %~dp0\6.jpg del /f /q %~dp0\6.jpg
if exist %~dp0\7.jpg del /f /q %~dp0\7.jpg
if exist %~dp0\8.jpg del /f /q %~dp0\8.jpg
if exist %~dp0\9.jpg del /f /q %~dp0\9.jpg
REM 启用延迟环境变量扩展 
setlocal enabledelayedexpansion 
REM 设置随机数的最小和最大值以及求模用的变量 
set min=0
set max=9 
set /a mod=!max!-!min!+1 
REM 产生[min,max]之间的随机数 
set /a r=!random!%%!mod!+!min! 
echo !r!
reg add "hkcu\control panel\desktop" /v "wallpaper" /d "%windir%\Web\Wallpaper\!r!.jpg" /f

copy "%windir%\Web\Wallpaper\!r!.jpg" %windir%\System32\oobe\info\backgrounds\backgroundDefault.jpg /y
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Background" /v OEMBackground /d 1 /t REG_SZ /f
if not exist %appdata%\壁纸锁屏.exe  copy %~dp0\壁纸锁屏.exe %appdata%\壁纸锁屏.exe 
REG ADD HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v 壁纸锁屏 /t REG_SZ /d %appdata%\壁纸锁屏.exe /F

