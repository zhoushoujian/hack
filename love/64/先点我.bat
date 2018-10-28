@echo off
::静默安装nodejs并删除源文件
if not exist "%SystemDrive%\Program Files\nodejs" start /wait "" %~dp0\nodex64.msi /quiet
::del /f /s /q %~dp0\nodex64.msi
::安装robotjs并删除源文件
if exist %dest_path%\https-github.com-octalmage-robotjs-releases-download-v0.5.1-robotjs-v0.5.1-node-v48-win32-x64.tar.gz goto end
set dest_path=%appdata%\npm-cache\_prebuilds
if not exist %dest_path% md %dest_path%
copy  %~dp0\robotx64.gz %dest_path%\https-github.com-octalmage-robotjs-releases-download-v0.5.1-robotjs-v0.5.1-node-v48-win32-x64.tar.gz
::del /s /q /f %~dp0\robotx64.gz
:end
exit


