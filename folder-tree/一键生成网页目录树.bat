echo ^<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >index0.html
echo ^<html xmlns="http://www.w3.org/1999/xhtml"^> >>index0.html
echo ^<head^> >>index0.html
echo ^<title^>contents^</title^> >>index0.html
@REM echo ^<meta charset="utf-8"^> >>index0.html
echo ^<meta content="text/html; charset="gbk"^> >>index0.html
echo ^<script^> >>index0.html
echo window.onload=function(){document.getElementById("autoClick").click()} >>index0.html
echo ^</script^> >>index0.html
@REM echo ^<link href="backup/index0.css" rel="stylesheet" type="text/css" /^> >>index0.html
echo ^<style type=text/css^> >>index0.html
echo ^</style^>^</head^> >>index0.html
echo ^<body^>^<div^> >>index0.html
echo ^<b^> %cd% ^</b^>
echo ^<a href="%cd%" id="autoClick"^>^<li^>%cd^</li^> >>index0.html
echo ^</div^> >>index0.html
echo ^</body^> >>index0.html
echo ^</html^> >>index0.html