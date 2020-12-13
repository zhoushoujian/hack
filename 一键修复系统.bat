rem made by zsj on 2018/4/1
@echo off
ver 
echo %date% %time%
systeminfo > C:\\systeminfo.txt
sfc /scannow
pause