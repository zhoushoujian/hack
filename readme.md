#注意：本仓库所有程序仅用作技术交流，严禁用于破坏他人文档或程序！！！

#prompt\yuan

这是一个可以让操作系统不停地弹错误提示框之类的病毒程序，因为此程序依赖nodejs，所以您可能需要先运行main.bat，

运行结束后再运行nod.bat文件即可让操作系统不停地弹框，弹框结束后会自动调用清理命令，将所有弹框清除掉。

#偷天换日

这是一个简易版的勒索病毒，实现原理是先创建一个叫jiaqq123456的windows账户，然后将其权限提升为系统管理员

然后更改当前使用的账户的密码为789(当然，中招的用户不会知道被改后的密码是什么)

最后，当用户重启电脑再次登录的时候就会提示密码错误，而且会有一个加qq123456的账户进行引导用户

#双击一下你就知道

这是一个无限重启的病毒程序，实现原理是先用批处理写一个名称叫run.bat的脚本到此程序所在的文件夹，

脚本内容为shutdown -g，也就是倒计时一分钟重启，这里的时间是可以设置的。

写完后将run.bat复制到开机启动的文件夹内，并将刚刚源文件删除，

最后通过call命令调用刚刚复制到开机启动的文件夹内的run.bat文件


