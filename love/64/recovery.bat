@echo off
reg add "hkcu\control panel\desktop" /v "wallpaper" /d "C:\Windows\Web\Wallpaper\Windows\img0.jpg" /f
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
taskkill /f /im explorer.exe
start "" "explorer.exe"
exit>nul
