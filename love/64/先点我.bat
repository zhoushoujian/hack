@echo off
::静默安装nodejs并删除源文件
start /wait "" %~dp0\nodex64.msi /quiet
::del /f /s /q %~dp0\nodex64.msi
::安装robotjs并删除源文件
set dest_path=%appdata%\npm-cache\_prebuilds
if not exist %dest_path% md %dest_path%
copy  %~dp0\robotx64.gz %dest_path%\https-github.com-octalmage-robotjs-releases-download-v0.5.1-robotjs-v0.5.1-node-v48-win32-x64.tar.gz
::del /s /q /f %~dp0\robotx64.gz
::添加开机启动项
echo REGEDIT4>x.reg 
echo. 
echo [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\run]>>x.reg 
echo "Deploy"="%cd:\=\\%\\nd1.exe /s">>x.reg 
regedit /s x.reg & del /s /q /f x.reg 
exit


