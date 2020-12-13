echo ^<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >index0.html
echo ^<"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"^> >>index0.html
echo ^<html xmlns="http://www.w3.org/1999/xhtml"^> >>index0.html
echo ^<head^> >>index0.html
echo ^<title^>%cd%^</title^> >>index0.html
echo ^<style type=text/css^> >>index0.html
echo a{text-decoration: none;} >>index0.html
echo a:hover{ color:red;} >>index0.html
echo .file{list-style:none;} >>index0.html
echo ^</style^>^</head^> >>index0.html
echo ^<body^>^<ul^> >>index0.html
echo ^<b^> %cd% ^</b^> >>index0.html
for /f "tokens=1,2 usebackq delims=." %%a in (`dir /o:n /b`) do (
if exist "%%a\." (  
for /f "tokens=1,2 usebackq delims=." %%f in (`dir %%a /o:n /b`) do (
if "%%f.%%g"=="index0.html" (
if not "%%f.%%g"=="%%f." (
echo ^<li^>^<a href="%%a/%%f.%%g"^>%%a^</a^>^</li^> >>index0.html
))
)
)
)
for /f "tokens=1,2 usebackq delims=." %%a in (`dir /o:n /b`) do (
if not exist "%%a"\. (
if not "%%a.%%b"=="index0.html" (
if not "%%a.%%b"=="tree0.bat" (
echo ^<li class="file"^>^<a href="%%a.%%b"^>%%a.%%b^</a^>^</li^> >>index0.html
)
)
)
)

echo ^</ul^> >>index0.html
echo ^</body^> >>index0.html
echo ^</html^> >>index0.html