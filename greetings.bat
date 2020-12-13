rem made by zwx492293 on 2018/5/6
@echo off
rem 根据ip地址或用户名判断机主姓名
rem 男士为帅锅，女士为妹纸，三个字的姓名默认取后面两个字
rem 如果机主名称不在列表里就打印用户名
rem 问候语包含早上好，中午好，下午好和晚上好
ver 
echo %date% %time%
::systeminfo > C:\\systeminfo.txt

for /f "tokens=4" %%a in ('route print^|findstr 0.0.0.0.*0.0.0.0') do (
 set IP=%%a
)
if %IP% equ 192.168.1.101 (goto %IP%) else (if %IP% equ 192.168.1.102 (goto %IP%) else (if %IP% equ 192.168.1.103 (goto %IP%) else (if %IP% equ 192.168.1.104 (goto %IP%) else (if %IP% equ 192.168.1.105 (goto %IP%) else (if %IP% equ 192.168.1.106 (goto %IP%) else (if %IP% equ 192.168.1.107 (goto %IP%) else (if %IP% equ 192.168.1.108 (goto %IP%) else (if %IP% equ 192.168.1.109 (goto %IP%) else (if %IP% equ 192.168.1.110 (goto %IP%) else (if %IP% equ 192.168.1.111 (goto %IP%) else (if %IP% equ 192.168.1.112 (goto %IP%) else (if %IP% equ 192.168.1.113 (goto %IP%) else (if %IP% equ 192.168.1.114 (goto %IP%) else (if %IP% equ 192.168.1.115 (goto %IP%) else (if %IP% equ 192.168.1.116 (goto %IP%) else (if %IP% equ 192.168.1.100 (goto %IP%))))))))))))))))) 
:192.168.1.101
set name=守俭帅锅
echo :192.168.1.100
goto time

set name=%username%
goto %name%
:wang
set name=王杰帅锅
goto time
:qian
set name=钱蓓妹纸
goto time
:huang
set name=念念妹纸
goto time
:chen
set name=陈力帅锅
goto time
:feng
set name=冯琳妹纸
goto time
:zhou
set name=守俭帅锅
echo zsj
goto time

:time
set day=%time:~0,2%
echo %day%
if %day% GEQ 0 if %day% LEQ 10 set greeting=早上好
if %day% GTR 10 if %day% LSS 14 set greeting=中午好
if %day% GEQ 14 if %day% LEQ 19 set greeting=下午好
if %day% GTR 19 if %day% LSS 24 set greeting=晚上好

echo 尊敬的 %name%, %greeting% ，祝您工作愉快！

pause