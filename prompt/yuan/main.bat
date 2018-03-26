@echo off
@start "" /wait %~dp0/node.msi /quiet
::del /s /q /f %~dp0/node.msi
exit