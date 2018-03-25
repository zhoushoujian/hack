set WSHshell = createobject("wscript.shell")
WSHshell.run "cmd.exe /c taskkill /f /im cmd.exe",0 ,true
Wscript.Sleep 20
WSHshell.run "nod.exe"